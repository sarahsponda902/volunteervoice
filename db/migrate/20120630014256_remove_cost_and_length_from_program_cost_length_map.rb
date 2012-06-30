class RemoveCostAndLengthFromProgramCostLengthMap < ActiveRecord::Migration
  def up
    remove_column :program_cost_length_maps, :cost
        remove_column :program_cost_length_maps, :length
      end

  def down
    add_column :program_cost_length_maps, :length, :string
    add_column :program_cost_length_maps, :cost, :string
  end
end
