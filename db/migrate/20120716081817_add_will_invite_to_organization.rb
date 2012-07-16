class AddWillInviteToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :will_invite, :boolean

  end
end
