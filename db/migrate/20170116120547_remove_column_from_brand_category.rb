class RemoveColumnFromBrandCategory < ActiveRecord::Migration
  def change
    remove_column :brand_categories, :name
    remove_column :brand_categories, :short_description
    remove_column :brand_categories, :long_description
    remove_column :brand_categories, :status
  end
end
