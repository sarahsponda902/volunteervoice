class AddAdminReadToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin_read, :boolean, :default => false

  end
end
