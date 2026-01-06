require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
    login_as users(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "index displays product list" do
    get products_url
    assert_response :success

    assert_select "h1", "Products"
    assert_select "tr", minimum: 1
  end

  test "index displays product attributes" do
    get products_url
    assert_response :success

    assert_select "h1, h2", @product.title
    assert_select "div", /\$[,\d]+\.\d\d/
  end

  test "should get new product form" do
    get new_product_url
    assert_response :success
  end

  test "new product form has required fields" do
    get new_product_url
    assert_response :success

    assert_select "form[action=?][method=?]", products_path, "post" do
      assert_select "input[name=?]", "product[title]"
      assert_select "textarea[name=?]", "product[description]"
      assert_select "input[name=?]", "product[price]"
      assert_select "input[type=file][name=?]", "product[image]"
    end
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: {
        product: {
          title: @title,
          description: @product.description,
          price: @product.price,
          image: file_fixture_upload("lorem.jpg", "image/jpeg")
        }
      }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit form" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "edit form submits to correct action" do
    get edit_product_url(@product)
    assert_response :success

    assert_select "form[action=?]", product_path(@product)
  end

  test "should update product" do
    patch product_url(@product), params: {
      product: {
        title: @title,
        description: @product.description,
        price: @product.price,
        image: file_fixture_upload("lorem.jpg", "image/jpeg")
      }
    }

    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_raises ActiveRecord::RecordNotDestroyed do
      delete product_url(products(:ruby))
    end

    assert Product.exists?(products(:ruby).id)
  end
end
