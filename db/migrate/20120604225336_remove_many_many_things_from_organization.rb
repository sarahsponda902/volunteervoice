class RemoveManyManyThingsFromOrganization < ActiveRecord::Migration
  def up
    remove_column :organizations, :mission
        remove_column :organizations, :program_costs_includes
        remove_column :organizations, :application_process
        remove_column :organizations, :business_model
        remove_column :organizations, :run_by
        remove_column :organizations, :price_ranges
        remove_column :organizations, :program_cost_breakdown
        remove_column :organizations, :program_costs
      end

  def down
    add_column :organizations, :program_costs, :string
    add_column :organizations, :program_cost_breakdown, :string
    add_column :organizations, :price_ranges, :string
    add_column :organizations, :run_by, :string
    add_column :organizations, :business_model, :string
    add_column :organizations, :application_process, :string
    add_column :organizations, :program_costs_includes, :string
    add_column :organizations, :mission, :string
  end
end
