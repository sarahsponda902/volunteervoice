class AddFieldsToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :lengths_of_program, :string

    add_column :programs, :food_situation, :string

    add_column :programs, :program_requirements, :string

  end
end
