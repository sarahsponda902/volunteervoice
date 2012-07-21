class AddSpecificLocationToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :specific_location, :string

  end
end
