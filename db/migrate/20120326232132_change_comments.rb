class ChangeComments < ActiveRecord::Migration
  def up
    remove_column :comments, :commenter
    add_column :comments, :commenter_id, :integer
  end
end
