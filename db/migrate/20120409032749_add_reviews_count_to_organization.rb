class AddReviewsCountToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :reviews_count, :integer

  end
end
