class RemoveAccommodationsFromPrograms < ActiveRecord::Migration
  def up
    remove_column :programs, :accommodations
      end

  def down
    add_column :programs, :accommodations, :string
  end
end
