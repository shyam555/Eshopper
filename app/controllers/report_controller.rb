class ReportController < ApplicationController
  def index
    @months = []
    @total_orders = []
    @orders = Order.all.group_by { |t| t.created_at.strftime("%B/%Y") } 
    @orders.reverse_each do |key, value|
      @months << key
      @total_orders << value.size
    end
  end

  def sales_report
  end

  def customer_registered
    @months = []
    @total_users = []
    @users = User.all.group_by { |t| t.created_at.strftime("%B/%Y") } 
    @users.reverse_each do |key, value|
      @months << key
      @total_users << value.size
    end
  end

  def coupon_used
    @months = []
    @total_coupons = []
    @coupons = CouponUsed.all.group_by { |t| t.created_at.strftime("%B/%Y") } 
    @coupons.reverse_each do |key, value|
      @months << key
      @total_coupons << value.size
    end
  end
end
