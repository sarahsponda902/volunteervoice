class AddLengthNameToProgramCostLengthMaps < ActiveRecord::Migration
  def change
    add_column :program_cost_length_maps, :length_name, :string

    add_column :program_cost_length_maps, :length_number, :integer

  end
end
