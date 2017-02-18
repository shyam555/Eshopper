class CreateTrackorders < ActiveRecord::Migration
  def change
    create_table :trackorders do |t|
      t.string :status
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
