class CreateOrganizationAccounts < ActiveRecord::Migration
  def change
    create_table :organization_accounts do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.string :email
      t.string :type_of_company
      t.boolean :nonprofit
      t.string :username
      t.boolean :notify
      t.string :country
      t.timestamps
    end
  end
end
