class ChangeColumnNameToBanner < ActiveRecord::Migration
  def change
    rename_column :banners, :image, :picture
  end
end
