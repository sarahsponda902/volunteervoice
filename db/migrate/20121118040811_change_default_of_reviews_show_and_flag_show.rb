class ChangeDefaultOfReviewsShowAndFlagShow < ActiveRecord::Migration
  def up
    change_column_default(:reviews, :show, false)
    change_column_default(:reviews, :flag_show, true)
  end

  def down
  end
end
