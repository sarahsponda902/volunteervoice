class AddOverallToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :overall, :integer

  end
end
