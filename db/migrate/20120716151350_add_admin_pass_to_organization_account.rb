class AddAdminPassToOrganizationAccount < ActiveRecord::Migration
  def change
    add_column :organization_accounts, :admin_pass, :string

  end
end
