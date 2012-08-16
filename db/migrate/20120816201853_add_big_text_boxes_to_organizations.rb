class AddBigTextBoxesToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :application_process, :text

    add_column :organizations, :price_breakdown, :text

  end
end
