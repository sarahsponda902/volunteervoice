class AddCostToProgramCostLengthMaps < ActiveRecord::Migration
  def change
    add_column :program_cost_length_maps, :cost, :integer

  end
end
