class ChangeNotifyToTrueForUsers < ActiveRecord::Migration
  def up
    change_column_default(:users, :notify, true)
  end

  def down
  end
end
