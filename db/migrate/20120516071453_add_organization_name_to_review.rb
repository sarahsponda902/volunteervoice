class AddOrganizationNameToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :organization_name, :string

  end
end
