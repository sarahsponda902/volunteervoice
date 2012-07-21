class AddProgramToNewReviews < ActiveRecord::Migration
  def change
    add_column :new_reviews, :program, :string

  end
end
