class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :address
  has_many :orderitems
  has_one :transection
  default_scope -> { order(id: :desc) }
end
