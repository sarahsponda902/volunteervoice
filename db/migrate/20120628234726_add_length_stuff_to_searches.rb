class AddLengthStuffToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :length_min_number, :integer

    add_column :searches, :length_min_param, :string

    add_column :searches, :length_max_number, :integer

    add_column :searches, :length_max_param, :string

  end
end
