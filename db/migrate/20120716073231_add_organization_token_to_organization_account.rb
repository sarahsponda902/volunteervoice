class AddOrganizationTokenToOrganizationAccount < ActiveRecord::Migration
  def change
    add_column :organization_accounts, :organization_token, :string

  end
end
