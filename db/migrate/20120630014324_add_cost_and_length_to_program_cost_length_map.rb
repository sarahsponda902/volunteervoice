class AddCostAndLengthToProgramCostLengthMap < ActiveRecord::Migration
  def change
    add_column :program_cost_length_maps, :cost, :float

    add_column :program_cost_length_maps, :length, :float

  end
end
