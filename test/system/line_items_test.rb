require "application_system_test_case"

class LineItemsTest < ApplicationSystemTestCase
  test "adding a product to the cart" do
    visit store_index_path

    click_on "Add to Cart", match: :first

    assert_current_path store_index_path
    assert_text "Your Pragmatic Catalog"
  end
end
