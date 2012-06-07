class RemoveProgramCostsBreakdownFromOrganization < ActiveRecord::Migration
  def up
    remove_column :organizations, :program_costs_breakdown
      end

  def down
    add_column :organizations, :program_costs_breakdown, :string
  end
end
