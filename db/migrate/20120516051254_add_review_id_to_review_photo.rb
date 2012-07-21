class AddReviewIdToReviewPhoto < ActiveRecord::Migration
  def change
    add_column :review_photos, :review_id, :integer

  end
end
