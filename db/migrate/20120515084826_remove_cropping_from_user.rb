class RemoveCroppingFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :cropping?
      end

  def down
    add_column :users, :cropping?, :string
  end
end
