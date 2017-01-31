class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :status, :admin
  end
end
