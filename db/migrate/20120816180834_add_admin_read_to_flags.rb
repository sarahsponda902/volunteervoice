class AddAdminReadToFlags < ActiveRecord::Migration
  def change
    add_column :flags, :admin_read, :boolean, :default => false

  end
end
