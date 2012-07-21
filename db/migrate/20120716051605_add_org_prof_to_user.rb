class AddOrgProfToUser < ActiveRecord::Migration
  def change
    add_column :users, :org, :boolean

    add_column :users, :org_pass, :string

    add_column :users, :org_update, :boolean

  end
end
