class AddPhoneAgainToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :phone, :string

  end
end
