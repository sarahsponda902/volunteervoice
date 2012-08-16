class RemoveApplicationProcessFromOrganizations < ActiveRecord::Migration
  def up
    remove_column :organizations, :application_process
      end

  def down
    add_column :organizations, :application_process, :string
  end
end
