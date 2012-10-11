class AddCropsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :crops, :boolean

  end
end
