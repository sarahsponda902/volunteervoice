class RemoveOrganizationTokenFromOrganizationAccount < ActiveRecord::Migration
  def up
    remove_column :organization_accounts, :organization_token
      end

  def down
    add_column :organization_accounts, :organization_token, :string
  end
end
