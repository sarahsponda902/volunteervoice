class AddCroppingToUser < ActiveRecord::Migration
  def change
    add_column :users, :cropping, :boolean

  end
end
