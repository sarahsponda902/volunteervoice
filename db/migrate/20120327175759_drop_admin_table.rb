class DropAdminTable < ActiveRecord::Migration
  def up
    drop_table :admins
  end


end
