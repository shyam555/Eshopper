class Checkout < ActiveRecord::Base

  def self.cart_total(cart_items,session)
    sub_total = 0
    discount = 0
    cart_items.each do |item|
      sub_total += (item.product.price.to_i * item.quantity.to_i) 
    end
    if session.present?
      coupon = Coupon.find_by(code: session)
      percent_off = coupon.percent_off
      #binding.pry
      discount = ((percent_off * sub_total) / 100)
      tax = 0.04 * sub_total
      shipping_cost = 40
      final_total = tax + sub_total + shipping_cost - discount
    else
      tax = 0.04 * sub_total
      shipping_cost = 40
      final_total = tax + sub_total + shipping_cost
    end
    return sub_total,discount,tax,shipping_cost,final_total
  end
end
