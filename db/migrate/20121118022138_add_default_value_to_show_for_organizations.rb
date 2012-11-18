class AddDefaultValueToShowForOrganizations < ActiveRecord::Migration
  def change
    change_column_default(:organizations, :show, false)
  end
end
