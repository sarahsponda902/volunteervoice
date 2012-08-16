class AddAccommodationsToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :accommodations, :text

  end
end
