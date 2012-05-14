class AddOverallToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :overall, :integer

  end
end
