class AddVolunteeredBeforeToUser < ActiveRecord::Migration
  def change
    add_column :users, :volunteered_before, :boolean

  end
end
