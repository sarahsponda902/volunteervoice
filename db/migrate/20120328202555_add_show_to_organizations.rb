class AddShowToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :show, :boolean

  end
end
