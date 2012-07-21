class AddHeadquartersLocationToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :headquarters_location, :text

  end
end
