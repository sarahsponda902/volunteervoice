class AddAFewToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :showing, :string

    add_column :searches, :sort_by, :string

    add_column :searches, :keywords, :string

  end
end
