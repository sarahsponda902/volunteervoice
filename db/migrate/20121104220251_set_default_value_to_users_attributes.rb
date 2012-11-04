class SetDefaultValueToUsersAttributes < ActiveRecord::Migration
  def up
    change_column :users, :unread_messages, :integer, :default => 0
    change_column :users, :messages_show, :boolean, :default => false
    change_column :users, :profile_show, :boolean, :default => false
  end

  def down
  end
end
