class Product < ApplicationRecord
    include ActionView::RecordIdentifier
  has_many :line_items
  has_one_attached :image

  before_destroy :ensure_not_referenced_by_any_line_item
  after_commit :broadcast_replace

  validates :title, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :title, length: { minimum: 10 }

  validate :acceptable_image

  private

  def acceptable_image
    unless image.attached?
      errors.add(:image, "must be attached")
      return
    end

    acceptable_types = [ "image/gif", "image/jpeg", "image/png" ]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a GIF, JPEG, or PNG")
    end
  end

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line Items present")
      throw :abort
    end
  end

  def broadcast_replace
    broadcast_replace_later_to(
      "products",
      target: dom_id(self),
      partial: "store/product",
      locals: { product: self, highlight: true }
    )
  end
end
