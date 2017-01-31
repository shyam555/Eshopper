class AddSubcategoryidToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :subcategory_id, :integer
  end
end
