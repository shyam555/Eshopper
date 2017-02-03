class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :email
      t.text :address_one
      t.text :address_two
      t.string :zip_code
      t.string :country
      t.string :state
      t.string :mobile_number
      t.string :address_type

      t.timestamps null: false
    end
  end
end
