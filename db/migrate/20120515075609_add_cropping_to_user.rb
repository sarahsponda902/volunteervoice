class AddCroppingToUser < ActiveRecord::Migration
  def up
    add_column :users, :cropping?, :boolean, :default => false
  end
end
