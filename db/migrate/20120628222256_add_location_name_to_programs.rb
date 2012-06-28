class AddLocationNameToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :location_name, :string

  end
end
