class AddThingersToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :program_started, :integer

    add_column :programs, :start_dates, :string

    add_column :programs, :program_structure, :text

    add_column :programs, :partnered_local_organizations, :string

    add_column :programs, :cost_includes, :text

    add_column :programs, :cost_doesnt_include, :text

    add_column :programs, :program_cost_breakdown, :text

    add_column :programs, :accommodations, :text

    add_column :programs, :check_it_out, :string

  end
end
