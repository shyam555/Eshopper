class RemoveColumnFromCategory < ActiveRecord::Migration
  def change
    add_column :categories, :parent, :integer
    remove_column :categories, :parent
    rename_column :categories, :subcategory_id, :category_id
  end
end
