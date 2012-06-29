class AddTypesOfProgramsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :types_of_programs, :string

  end
end
