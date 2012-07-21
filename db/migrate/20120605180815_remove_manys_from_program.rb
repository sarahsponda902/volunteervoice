class RemoveManysFromProgram < ActiveRecord::Migration
  def up
    remove_column :programs, :program_started
        remove_column :programs, :cost_doesnt_include
      end

  def down
    add_column :programs, :cost_doesnt_include, :string
    add_column :programs, :program_started, :string
  end
end
