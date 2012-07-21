class RemoveLengthsFromSearches < ActiveRecord::Migration
  def up
    remove_column :searches, :lengths
      end

  def down
    add_column :searches, :lengths, :string
  end
end
