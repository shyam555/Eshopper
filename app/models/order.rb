class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :address
  has_many :orderitems
  default_scope -> { order(id: :desc) }
  after_update :track_order
  
  def track_order
    @order = Order.find(id)
    @track_order = Trackorder.new(status: @order.order_status, order_id: @order.id)
    @track_order.save
  end

  def self.set_sub_total(current_user)
    sub_total = 0
    current_user.cart_items.each do |item|
      sub_total += (item.product.price.to_i * item.quantity.to_i) 
    end
    return sub_total
  end
end
