class AddProfileShowToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_show, :boolean, :default => true

  end
end
