class AddManysYeaToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :program_started, :string

    add_column :programs, :cost_doesnt_include, :text

  end
end
