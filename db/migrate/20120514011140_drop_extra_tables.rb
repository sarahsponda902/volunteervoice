class DropExtraTables < ActiveRecord::Migration
  def up
    drop_table :comments
    drop_table :contact_messages
    drop_table :impacts
    drop_table :overalls
    drop_table :preparations
    drop_table :rates
    drop_table :ratings
    drop_table :review_os
    drop_table :structures
    drop_table :update_messages
  end

  def down
  end
end
