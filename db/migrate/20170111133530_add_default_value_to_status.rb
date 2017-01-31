class AddDefaultValueToStatus < ActiveRecord::Migration
  def up
    change_column :users, :status, :boolean, :default => false
  end

  def down
    change_column :users, :status, :boolean, :default => nil
  end
end
