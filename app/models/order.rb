class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :address
  has_many :orderitems
  default_scope -> { order(id: :desc) }
end
