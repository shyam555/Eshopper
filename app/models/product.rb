class Product < ActiveRecord::Base
  has_many :pictures, as: :imageable
  belongs_to :brand

  has_many :product_category
  has_many :category, :through => :product_category
end
