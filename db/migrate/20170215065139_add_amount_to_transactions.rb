class AddAmountToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :amount, :decimal
    add_column :transactions, :paid, :boolean, :default => false
    add_column :transactions, :refunded, :boolean, :default => false
    add_column :transactions, :status, :string
  end
end
