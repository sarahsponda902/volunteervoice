class RemovePhoneFromOrganization < ActiveRecord::Migration
  def up
    remove_column :organizations, :phone
      end

  def down
    add_column :organizations, :phone, :string
  end
end
