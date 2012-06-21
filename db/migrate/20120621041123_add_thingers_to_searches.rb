class AddThingersToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :sent_from, :string

  end
end
