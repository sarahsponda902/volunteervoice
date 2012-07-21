class RemoveTimeFrameFromNewReviews < ActiveRecord::Migration
  def up
    remove_column :new_reviews, :time_frame
      end

  def down
    add_column :new_reviews, :time_frame, :string
  end
end
