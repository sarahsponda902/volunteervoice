class AddMessagesShowToUsers < ActiveRecord::Migration
  def change
    add_column :users, :messages_show, :boolean

  end
end
