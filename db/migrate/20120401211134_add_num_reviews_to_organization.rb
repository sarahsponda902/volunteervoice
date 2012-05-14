class AddNumReviewsToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :num_reviews, :integer
  end
end
