class Coupon < ActiveRecord::Base

  def self.destroy_coupon(cart_items, session)
    sub_total1 = 0
    discount = 0
    cart_items.each do |item|
      sub_total1 += (item.product.price.to_i * item.quantity.to_i) 
    end
    if session.present?
      coupon = Coupon.find_by(code: session)
      percent_off = coupon.percent_off
      discount = ((percent_off * sub_total1) / 100)
      tax = 0.04 * sub_total1
      shipping_cost = 40
      final_total = tax + sub_total1 + shipping_cost - discount
    else
      tax = 0.04 * sub_total1
      shipping_cost = 40
      final_total = tax + sub_total1 + shipping_cost
    end
    return sub_total1, discount, tax, shipping_cost, final_total
  end

end
