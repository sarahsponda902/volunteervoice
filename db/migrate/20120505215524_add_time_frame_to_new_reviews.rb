class AddTimeFrameToNewReviews < ActiveRecord::Migration
  def change
    add_column :new_reviews, :time_frame, :string

  end
end
