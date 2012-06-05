class RemoveProgramModelFromOrganization < ActiveRecord::Migration
  def up
    remove_column :organizations, :program_model
      end

  def down
    add_column :organizations, :program_model, :string
  end
end
