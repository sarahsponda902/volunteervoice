class AddOrganizationNameToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :organization_name, :string

  end
end
