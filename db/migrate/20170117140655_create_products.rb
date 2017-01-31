class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :short_description
      t.text :long_description
      t.boolean :status
      t.decimal :price
      t.integer :quantity
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
