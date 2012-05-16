class RemovePropertyIdFromReviewPhoto < ActiveRecord::Migration
  def up
    remove_column :review_photos, :property_id
      end

  def down
    add_column :review_photos, :property_id, :string
  end
end
