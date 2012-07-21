class AddInviteEmailToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :invite_email, :string

  end
end
