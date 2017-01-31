class CreateBrandCategories < ActiveRecord::Migration
  def change
    create_table :brand_categories do |t|
      t.string :name
      t.string :short_description
      t.text :long_description
      t.boolean :status
      t.references :category, index: true, foreign_key: true
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
