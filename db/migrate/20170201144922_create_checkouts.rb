class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|

      t.timestamps null: false
    end
  end
end
