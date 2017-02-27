module ChargesHelper

  def set_total(current_user)
    sub_total = 0
    discount = 0
    current_user.cart_items.each do |item|
      sub_total += (item.product.price.to_i * item.quantity.to_i) 
    end
    if session[:coupon_code].present?
      coupon = Coupon.find_by(code: session[:coupon_code])
      percent_off = coupon.percent_off
      discount = ((percent_off * sub_total) / 100)
      tax = 0.04 * sub_total
      shipping_cost = 40
      final_total = tax + sub_total + shipping_cost - discount
    else
      tax = 0.04 * sub_total
      shipping_cost = 40
      final_total = tax + sub_total + shipping_cost
    end
    return sub_total, discount, tax ,shipping_cost, final_total
  end

  def payment_page(order_items)
    sub_total = 0
    discount = 0 
    order_items.each do |item|                   
      sub_total += item.product.price * item.quantity            
    end
    coupon_used =CouponUsed.find_by(order_id: @order.id, user_id: current_user.id)
    if coupon_used.present?
      coupon = Coupon.find(coupon_used.coupon_id)
    end
    if coupon.present?
      discount =  (sub_total * coupon.percent_off )/100
      tax = 0.04 * sub_total
      shipping_charges = 40
      final_total = tax + sub_total + shipping_charges - discount
    else
      tax = 0.04 * sub_total
      shipping_charges = 40
      final_total = tax + sub_total + shipping_charges
    end
    return sub_total, discount, tax ,shipping_charges, final_total
  end

  def order_status(order_id)
    success = Trackorder.where(order_id: order_id, status: 'successfull').last.created_at.strftime("%d %B %Y") if Trackorder.where(order_id: order_id, status: 'successfull').last.present?
    in_transit = Trackorder.where(order_id: order_id, status: 'in-transit').last.created_at.strftime("%d %B %Y") if Trackorder.where(order_id: order_id, status: 'in-transit').last.present?
    shipped = Trackorder.where(order_id: order_id, status: 'shipped').last.created_at.strftime("%d %B %Y") if Trackorder.where(order_id: order_id, status: 'shipped').last.present?
    delivered = Trackorder.where(order_id: order_id,status: 'delivered').last.created_at.strftime("%d %B %Y") if Trackorder.where(order_id: order_id, status: 'delivered').last.present?
    return success, in_transit, shipped, delivered
  end

end
