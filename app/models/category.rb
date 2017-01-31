class Category < ActiveRecord::Base
  has_many :subcategories, class_name: "Category", foreign_key: "category_id", dependent: :destroy
  
  has_many :brands, :through => :brand_categories
  has_many :brand_categories
  belongs_to :category

  has_many :products, :through => :product_category
  has_many :product_category
end
