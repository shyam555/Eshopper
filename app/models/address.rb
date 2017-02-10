class Address < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  #validates :name, :email, :address_one, :mobile_number, presence: true
end
