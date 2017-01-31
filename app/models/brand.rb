class Brand < ActiveRecord::Base
  default_scope  { order(:name => :desc) }
  has_many :brand_categories
  has_many :categories, :through => :brand_categories
  has_many :products
end
