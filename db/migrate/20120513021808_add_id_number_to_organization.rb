class AddIdNumberToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :id_number, :string

  end
end
