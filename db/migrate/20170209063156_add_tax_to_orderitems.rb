class AddTaxToOrderitems < ActiveRecord::Migration
  def change
    add_column :orderitems, :tax, :decimal
    add_column :orderitems, :shipping_charges, :decimal
  end
end
