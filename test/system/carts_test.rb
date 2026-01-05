require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  test "cart visibility toggles" do
    visit store_index_url

    assert_no_selector "#cart"

    click_on "Add to Cart", match: :first

    assert_selector "#cart"

    click_on "Empty Cart"

    assert_no_selector "#cart"
  end

    test "cart is highlighted when updated" do
    visit store_index_url

    click_on "Add to Cart", match: :first

    assert_selector ".line-item-highlight"
    end
end
