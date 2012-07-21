class AddStuffToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :phone, :integer

    add_column :organizations, :email, :string

    add_column :organizations, :operating_since, :integer

    add_column :organizations, :num_vols_date, :integer

    add_column :organizations, :num_vols_yr, :integer

    add_column :organizations, :application_process, :text

    add_column :organizations, :business_model, :text

    add_column :organizations, :program_model, :text

    add_column :organizations, :good_to_know, :text

  end
end
