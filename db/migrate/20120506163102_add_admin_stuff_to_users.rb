class AddAdminStuffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin_pass, :string

    add_column :users, :admin_update, :boolean

  end
end
