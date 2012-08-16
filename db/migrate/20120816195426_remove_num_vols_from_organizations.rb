class RemoveNumVolsFromOrganizations < ActiveRecord::Migration
  def up
    remove_column :organizations, :num_vols_yr
        remove_column :organizations, :num_vols_date
      end

  def down
    add_column :organizations, :num_vols_date, :string
    add_column :organizations, :num_vols_yr, :string
  end
end
