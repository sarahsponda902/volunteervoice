class AddUsernameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :username, :string
  end
end
