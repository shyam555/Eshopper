class AddReplyToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :reply, :text
  end
end
