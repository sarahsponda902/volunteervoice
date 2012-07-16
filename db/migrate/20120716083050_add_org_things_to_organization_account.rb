class AddOrgThingsToOrganizationAccount < ActiveRecord::Migration
  def change
    add_column :organization_accounts, :organization_id, :integer

    add_column :organization_accounts, :organization_name, :string

  end
end
