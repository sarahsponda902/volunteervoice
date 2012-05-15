class AddCropsToUser < ActiveRecord::Migration
  def change
    add_column :users, :crops, :boolean

  end
end
