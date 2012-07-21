class CreateNewReviews < ActiveRecord::Migration
  def change
    create_table :new_reviews do |t|

      t.timestamps
    end
  end
end
