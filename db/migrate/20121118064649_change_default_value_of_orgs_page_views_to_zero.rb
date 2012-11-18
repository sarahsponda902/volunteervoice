class ChangeDefaultValueOfOrgsPageViewsToZero < ActiveRecord::Migration
  def up
    change_column_default(:organizations, :page_views, 0)
  end

  def down
    change_column_default(:organizations, :reviewed_at, nil)
  end
end
