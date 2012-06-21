class RemovePricesFromSearches < ActiveRecord::Migration
  def up
    remove_column :searches, :prices
      end

  def down
    add_column :searches, :prices, :string
  end
end
