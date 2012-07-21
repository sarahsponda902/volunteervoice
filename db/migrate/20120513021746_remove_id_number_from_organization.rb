class RemoveIdNumberFromOrganization < ActiveRecord::Migration
  def up
    remove_column :organizations, :id_number
      end

  def down
    add_column :organizations, :id_number, :string
  end
end
