class AddOrganizationIdToProgramSubjects < ActiveRecord::Migration
  def change
    add_column :program_subjects, :organization_id, :integer

  end
end
