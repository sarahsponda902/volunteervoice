class AddQuestionTHingsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :run_by, :string

    add_column :organizations, :id_number, :integer

    add_column :organizations, :volunteer_program_model, :text

    add_column :organizations, :price_ranges, :string

  end
end
