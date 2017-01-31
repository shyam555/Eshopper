class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :quantity, default: 0
      t.references :user, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
