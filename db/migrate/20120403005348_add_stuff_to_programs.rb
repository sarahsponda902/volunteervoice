class AddStuffToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :subject, :string

    add_column :programs, :group_size, :integer

    add_column :programs, :headquarters, :string

    add_column :programs, :length, :integer

  end
end
