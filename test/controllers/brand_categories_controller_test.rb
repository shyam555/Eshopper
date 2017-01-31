require 'test_helper'

class BrandCategoriesControllerTest < ActionController::TestCase
  setup do
    @brand_category = brand_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brand_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brand_category" do
    assert_difference('BrandCategory.count') do
      post :create, brand_category: { brand_id: @brand_category.brand_id, category_id: @brand_category.category_id, long_description: @brand_category.long_description, name: @brand_category.name, short_description: @brand_category.short_description, status: @brand_category.status }
    end

    assert_redirected_to brand_category_path(assigns(:brand_category))
  end

  test "should show brand_category" do
    get :show, id: @brand_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brand_category
    assert_response :success
  end

  test "should update brand_category" do
    patch :update, id: @brand_category, brand_category: { brand_id: @brand_category.brand_id, category_id: @brand_category.category_id, long_description: @brand_category.long_description, name: @brand_category.name, short_description: @brand_category.short_description, status: @brand_category.status }
    assert_redirected_to brand_category_path(assigns(:brand_category))
  end

  test "should destroy brand_category" do
    assert_difference('BrandCategory.count', -1) do
      delete :destroy, id: @brand_category
    end

    assert_redirected_to brand_categories_path
  end
end
