class AddLotsoToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :misson, :text

    add_column :organizations, :program_costs_includes, :text

    add_column :organizations, :application_process, :string

    add_column :organizations, :program_model_string, :string

    add_column :organizations, :business_model, :string

    add_column :organizations, :run_by, :string

    add_column :organizations, :price_ranges, :string

    add_column :organizations, :program_costs_breakdown, :string

    add_column :organizations, :program_costs_doesnt_include, :text

  end
end
