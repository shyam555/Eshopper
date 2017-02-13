class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.references :orderitem, index: true, foreign_key: true
      t.string :token

      t.timestamps null: false
    end
  end
end
