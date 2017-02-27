class CartItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  def self.cart_total(cart_items,session)
    sub_total = 0
    discount = 0
    cart_items.each do |item|
      sub_total += (item.product.price.to_i * item.quantity.to_i) 
    end
    if session.present?
      coupon = Coupon.find_by(code: session)
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
    return sub_total, discount, tax, shipping_cost, final_total
  end

  def self.update_cart(params_qty, params_quantity, cart_item)
    if params_qty == "minus"
      if cart_item.quantity == 1
        cart_item.quantity=1
      else
        cart_item.quantity -= 1
      end
    elsif params_qty == "plus"
      cart_item.quantity += 1
    else
      quantity = params_quantity.to_i
      if params_quantity == ""
        cart_item.quantity = @cart_item.quantity
      elsif params_quantity.to_i < 1
        cart_item.quantity = 1
      else
        cart_item.quantity = quantity
      end
    end
    return cart_item.quantity
  end

  def self.update_cart_item(cart_item, boolean, cart_item_quantity)
    if boolean.present?
      quantity_one = cart_item_quantity
      cart_item.quantity += quantity_one.to_i
    else
      cart_item.quantity += 1
    end
  end
end
