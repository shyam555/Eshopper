class AddParentToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :parent, :integer
  end
end
