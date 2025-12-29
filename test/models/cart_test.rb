require "test_helper"

class CartTest < ActiveSupport::TestCase
  # Verify that adding unique and duplicate products results in separate line items - Play Time Chapter 10
  test "adding unique products" do
    cart = Cart.create
    cart.add_product(products(:ruby)).save!
    cart.add_product(products(:one)).save!
    assert_equal 2, cart.line_items.size
    assert_equal products(:ruby).price + products(:one).price, cart.total_price
  end

  test "adding duplicate product" do
    cart = Cart.create
    cart.add_product(products(:ruby)).save!
    cart.add_product(products(:ruby)).save!

    assert_equal 1, cart.line_items.size
    assert_equal 2, cart.line_items.first.quantity
  end
end
