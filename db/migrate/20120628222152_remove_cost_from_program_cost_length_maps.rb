class RemoveCostFromProgramCostLengthMaps < ActiveRecord::Migration
  def up
    remove_column :program_cost_length_maps, :cost
      end

  def down
    add_column :program_cost_length_maps, :cost, :string
  end
end
