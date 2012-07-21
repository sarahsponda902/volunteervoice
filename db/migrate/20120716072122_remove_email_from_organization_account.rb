class RemoveEmailFromOrganizationAccount < ActiveRecord::Migration
  def up
    remove_column :organization_accounts, :email
      end

  def down
    add_column :organization_accounts, :email, :string
  end
end
