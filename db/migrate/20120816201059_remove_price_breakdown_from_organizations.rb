class RemovePriceBreakdownFromOrganizations < ActiveRecord::Migration
  def up
    remove_column :organizations, :price_breakdown
      end

  def down
    add_column :organizations, :price_breakdown, :string
  end
end
