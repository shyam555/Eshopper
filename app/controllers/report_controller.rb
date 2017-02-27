class ReportController < ApplicationController
  before_action :set_monts, only: [:sales_report, :customer_registered, :coupon_used]
  def index
    
  end

  def sales_report
    @total_orders = []
    @orders = Order.all.group_by { |t| t.created_at.strftime("%B/%Y") } 
    @orders.reverse_each do |key, value|
      @months << key
      @total_orders << value.size
    end
  end

  def customer_registered
    @total_users = []
    @users = User.all.group_by { |t| t.created_at.strftime("%B/%Y") } 
    @users.reverse_each do |key, value|
      @months << key
      @total_users << value.size
    end
  end

  def coupon_used
    @total_coupons = []
    @coupons = CouponUsed.all.group_by { |t| t.created_at.strftime("%B/%Y") } 
    @coupons.reverse_each do |key, value|
      @months << key
      @total_coupons << value.size
    end
  end

  private
  def set_monts
    @months = []
  end
  
end
