class ChangeDefaultOfOrgReviewedAt < ActiveRecord::Migration
  def up
    change_column_default(:organizations, :reviewed_at, DateTime.strptime("01-01-1800", "%m-%d-%Y"))
  end

  def down
    change_column_default(:organizations, :reviewed_at, nil)
  end
end
