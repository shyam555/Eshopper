class RemoveColummmnCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :created_by
  end
end
