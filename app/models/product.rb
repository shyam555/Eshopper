class Product < ActiveRecord::Base
  has_many :pictures, as: :imageable
  belongs_to :brand

  has_many :product_category
  has_many :categories, :through => :product_category

  has_and_belongs_to_many(:products,
    :join_table => "recommended_products",
    :foreign_key => "product_id",
    :association_foreign_key => "recommended_product_id")
end
