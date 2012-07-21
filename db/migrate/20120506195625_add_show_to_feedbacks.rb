class AddShowToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :show, :boolean

  end
end
