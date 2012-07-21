class AddOrganizationIdToProgramSizes < ActiveRecord::Migration
  def change
    add_column :program_sizes, :organization_id, :integer

  end
end
