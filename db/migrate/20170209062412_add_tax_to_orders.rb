class AddTaxToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :tax, :decimal
  end
end
