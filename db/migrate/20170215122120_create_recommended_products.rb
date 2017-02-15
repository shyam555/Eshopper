class CreateRecommendedProducts < ActiveRecord::Migration
  def change
    create_table :recommended_products, :force => true, :id => false do |t|
      t.integer :product_id, :null => false
      t.integer :recommended_product_id, :null => false
      t.timestamps null: false
    end
  end
end
