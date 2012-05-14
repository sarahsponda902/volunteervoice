class AddTwoThingsToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :length, :string

    add_column :programs, :group_size, :string

  end
end
