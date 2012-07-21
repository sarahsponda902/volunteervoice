class RemoveChartFromPrograms < ActiveRecord::Migration
  def up
    remove_column :programs, :chart_file_name
        remove_column :programs, :chart_content_type
        remove_column :programs, :chart_file_size
        remove_column :programs, :chart_updated_at
      end

  def down
    add_column :programs, :chart_updated_at, :string
    add_column :programs, :chart_file_size, :string
    add_column :programs, :chart_content_type, :string
    add_column :programs, :chart_file_name, :string
  end
end
