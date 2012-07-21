class AddUnreadMessagesToUser < ActiveRecord::Migration
  def change
    add_column :users, :unread_messages, :integer

  end
end
