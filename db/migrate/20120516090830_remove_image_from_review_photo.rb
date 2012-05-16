class RemoveImageFromReviewPhoto < ActiveRecord::Migration
  def up
    remove_column :review_photos, :image
      end

  def down
    add_column :review_photos, :image, :string
  end
end
