class AddOrganizationAccountIdToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :organization_account_id, :integer

  end
end
