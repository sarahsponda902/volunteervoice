class AddReviewedAtToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :reviewed_at, :datetime

  end
end
