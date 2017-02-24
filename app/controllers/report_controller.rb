class ReportController < ApplicationController
  def index
    @months = []
    @total_orders = []
    @orders = Order.all.group_by { |t| t.created_at.strftime("%B/%Y") } 
    @orders.reverse_each do |key, value|
      @months << key
      @total_orders << value.size
    end
    #binding.pry
  end

  def sales_report
  end

  def customer_registered
  end

  def coupon_used
  end
end
