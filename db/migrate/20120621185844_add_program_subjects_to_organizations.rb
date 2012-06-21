class AddProgramSubjectsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :program_subjects, :text

  end
end
