class AddNewThingsToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :organization_name, :string

    add_column :contacts, :country, :string

    add_column :contacts, :organization_url, :string

    add_column :contacts, :has_profile, :string

    add_column :contacts, :main_contact, :string

    add_column :contacts, :position_of_contact, :string

    add_column :contacts, :contact_email, :string

  end
end
