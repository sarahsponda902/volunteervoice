class AddEmailConfirmationToOrganizationAccounts < ActiveRecord::Migration
  def change
    add_column :organization_accounts, :email_confirmation, :string

  end
end
