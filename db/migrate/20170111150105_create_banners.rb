class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :title
      t.text :content
      t.string :image
      t.string :status

      t.timestamps null: false
    end
  end
end
