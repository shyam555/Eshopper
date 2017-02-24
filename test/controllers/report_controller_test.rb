require 'test_helper'

class ReportControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get sales_report" do
    get :sales_report
    assert_response :success
  end

  test "should get customer_registered" do
    get :customer_registered
    assert_response :success
  end

  test "should get coupon_used" do
    get :coupon_used
    assert_response :success
  end

end
