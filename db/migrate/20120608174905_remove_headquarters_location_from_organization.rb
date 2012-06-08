class RemoveHeadquartersLocationFromOrganization < ActiveRecord::Migration
  def up
    remove_column :organizations, :headquarters_location
      end

  def down
    add_column :organizations, :headquarters_location, :string
  end
end
