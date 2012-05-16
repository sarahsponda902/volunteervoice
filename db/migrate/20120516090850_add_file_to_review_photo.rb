class AddFileToReviewPhoto < ActiveRecord::Migration
  def change
    add_column :review_photos, :file, :string

  end
end
