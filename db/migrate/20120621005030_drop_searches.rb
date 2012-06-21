class DropSearches < ActiveRecord::Migration
  def up
    drop_table :searches
  end
end
