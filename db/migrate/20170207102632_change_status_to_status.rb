class ChangeStatusToStatus < ActiveRecord::Migration
  def change
     rename_column :orders, :order_satus, :order_status
  end
end
