class AddChartToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :chart, :string

  end
end
