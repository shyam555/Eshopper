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
end
