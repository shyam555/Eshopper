class RemoveColummmnBrand < ActiveRecord::Migration
  def change
    remove_column :brands, :short_description
    remove_column :brands, :long_description
  end
end
