class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
