class CartItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  # def self.sub_total(cart_items)
  #   sub_total = 0
  #   discount = 0
  #   cart_items.each do |item|
  #     sub_total += (item.product.price.to_i * item.quantity.to_i) 
  #   end
  # end
end
