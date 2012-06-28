class RemoveProgramLengths < ActiveRecord::Migration
  def up
    drop_table :program_lengths
  end
end
