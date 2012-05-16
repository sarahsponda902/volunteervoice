class DropReviewPhotos < ActiveRecord::Migration
  def up
    drop_table :review_photos
  end
end
