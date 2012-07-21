class RemoveDoesntIncludeFromOrganizations < ActiveRecord::Migration
  def up
    remove_column :organizations, :program_costs_doesnt_include
      end

  def down
    add_column :organizations, :program_costs_doesnt_include, :string
  end
end
