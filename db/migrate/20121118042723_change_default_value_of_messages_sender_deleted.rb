class ChangeDefaultValueOfMessagesSenderDeleted < ActiveRecord::Migration
  def up
    change_column_default(:messages, :sender_deleted, false)
    change_column_default(:messages, :recipient_deleted, false)
  end

  def down
  end
end
