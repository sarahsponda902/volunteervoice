class RemoveTimeFrameFromReviews < ActiveRecord::Migration
  def up
    remove_column :reviews, :time_frame
      end

  def down
    add_column :reviews, :time_frame, :string
  end
end
