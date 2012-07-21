class RemoveProgramSubjectsFromOrganizations < ActiveRecord::Migration
  def up
    remove_column :organizations, :program_subjects
      end

  def down
    add_column :organizations, :program_subjects, :string
  end
end
