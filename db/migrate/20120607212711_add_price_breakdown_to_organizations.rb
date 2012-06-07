class AddPriceBreakdownToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :price_breakdown, :string

  end
end
