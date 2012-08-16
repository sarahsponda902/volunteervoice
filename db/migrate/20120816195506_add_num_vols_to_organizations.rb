class AddNumVolsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :num_vols_yr, :string

    add_column :organizations, :num_vols_date, :string

  end
end
