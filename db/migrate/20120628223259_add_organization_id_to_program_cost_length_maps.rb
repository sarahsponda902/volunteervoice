class AddOrganizationIdToProgramCostLengthMaps < ActiveRecord::Migration
  def change
    add_column :program_cost_length_maps, :organization_id, :integer

  end
end
