class AddAttachmentChartToProgram < ActiveRecord::Migration
  def self.up
    add_column :programs, :chart_file_name, :string
    add_column :programs, :chart_content_type, :string
    add_column :programs, :chart_file_size, :integer
    add_column :programs, :chart_updated_at, :datetime
  end

  def self.down
    remove_column :programs, :chart_file_name
    remove_column :programs, :chart_content_type
    remove_column :programs, :chart_file_size
    remove_column :programs, :chart_updated_at
  end
end
