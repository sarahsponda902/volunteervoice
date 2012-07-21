class AddMissionToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :mission, :text

  end
end
