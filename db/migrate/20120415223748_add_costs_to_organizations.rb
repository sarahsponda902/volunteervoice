class AddCostsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :program_costs, :integer

    add_column :organizations, :program_costs_includes, :string

    add_column :organizations, :program_costs_doesnt_include, :string

    add_column :organizations, :program_costs_breakdown, :text

  end
end
