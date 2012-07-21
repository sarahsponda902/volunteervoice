class RemoveOrgThingsFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :org
        remove_column :users, :org_pass
        remove_column :users, :org_update
        remove_column :users, :organization_id
      end

  def down
    add_column :users, :organization_id, :string
    add_column :users, :org_update, :string
    add_column :users, :org_pass, :string
    add_column :users, :org, :string
  end
end
