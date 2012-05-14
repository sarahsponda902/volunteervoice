class AddReviewIdToFlags < ActiveRecord::Migration
  def change
    add_column :flags, :review_id, :integer

  end
end
