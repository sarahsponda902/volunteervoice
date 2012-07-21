class AddThingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :dob, :datetime

    add_column :users, :notify, :boolean

    add_column :users, :verify, :boolean

  end
end
