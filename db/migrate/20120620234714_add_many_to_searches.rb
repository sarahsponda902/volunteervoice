class AddManyToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :subjects, :text

    add_column :searches, :regions, :text

    add_column :searches, :lengths, :text

    add_column :searches, :sizes, :text

    add_column :searches, :prices, :text

  end
end
