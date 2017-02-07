class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :payment_gateway_id
      t.string :transection_id
      t.string :order_satus
      t.decimal :grand_total
      t.decimal :shipping_charges
      t.references :user, index: true, foreign_key: true
      t.references :address, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
