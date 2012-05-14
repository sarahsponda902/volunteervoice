class AddSenderDeletedToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sender_deleted, :boolean

  end
end
