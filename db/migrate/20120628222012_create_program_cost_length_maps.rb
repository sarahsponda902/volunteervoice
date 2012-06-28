class CreateProgramCostLengthMaps < ActiveRecord::Migration
  def change
    create_table :program_cost_length_maps do |t|
      t.integer :program_id
      t.decimal :cost
      t.integer :length

      t.timestamps
    end
  end
end
