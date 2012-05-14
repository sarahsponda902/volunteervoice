class AddTimeFrameToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :time_frame, :string

  end
end
