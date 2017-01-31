class RemoveColumnFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :parent
    rename_column :categories, :subcategory_id, :category_id
  end
end
