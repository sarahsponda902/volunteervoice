class RemoveGroupSizesAndLengthsFromPrograms < ActiveRecord::Migration
  def up
    remove_column :programs, :group_size
        remove_column :programs, :length
      end

  def down
    add_column :programs, :length, :string
    add_column :programs, :group_size, :string
  end
end
