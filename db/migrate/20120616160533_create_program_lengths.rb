class CreateProgramLengths < ActiveRecord::Migration
  def change
    create_table :program_lengths do |t|

      t.timestamps
    end
  end
end
