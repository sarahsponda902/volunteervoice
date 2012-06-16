class CreateProgramSizes < ActiveRecord::Migration
  def change
    create_table :program_sizes do |t|

      t.timestamps
    end
  end
end
