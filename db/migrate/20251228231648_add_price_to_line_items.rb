class AddPriceToLineItems < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:line_items, :price)
      add_column :line_items, :price, :decimal, precision: 8, scale: 2
    end

    LineItem.all.each do |line_item|
      line_item.update(price: line_item.product.price)
    end
  end
end
