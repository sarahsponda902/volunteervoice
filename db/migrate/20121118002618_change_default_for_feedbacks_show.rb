class ChangeDefaultForFeedbacksShow < ActiveRecord::Migration
  def up
    change_column_default(:feedbacks, :show, false)
  end

  def down
    change_column_default(:feedbacks, :show, nil)
  end
end
