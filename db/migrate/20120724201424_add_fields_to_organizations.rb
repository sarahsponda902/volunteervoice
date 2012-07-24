class AddFieldsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :additional_fees, :string

    add_column :organizations, :full_time_staff, :integer

  end
end
