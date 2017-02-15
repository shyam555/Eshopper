require 'test_helper'

class RecommendedProductsControllerTest < ActionController::TestCase
  setup do
    @recommended_product = recommended_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recommended_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recommended_product" do
    assert_difference('RecommendedProduct.count') do
      post :create, recommended_product: {  }
    end

    assert_redirected_to recommended_product_path(assigns(:recommended_product))
  end

  test "should show recommended_product" do
    get :show, id: @recommended_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recommended_product
    assert_response :success
  end

  test "should update recommended_product" do
    patch :update, id: @recommended_product, recommended_product: {  }
    assert_redirected_to recommended_product_path(assigns(:recommended_product))
  end

  test "should destroy recommended_product" do
    assert_difference('RecommendedProduct.count', -1) do
      delete :destroy, id: @recommended_product
    end

    assert_redirected_to recommended_products_path
  end
end
