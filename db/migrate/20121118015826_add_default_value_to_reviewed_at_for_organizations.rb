class AddDefaultValueToReviewedAtForOrganizations < ActiveRecord::Migration
  def change
    change_column :organizations, :reviewed_at, :datetime, :null => false
  end
end
