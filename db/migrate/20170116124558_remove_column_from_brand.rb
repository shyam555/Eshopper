class RemoveColumnFromBrand < ActiveRecord::Migration
  def change
    remove_column :brands, :category_id
  end
end
