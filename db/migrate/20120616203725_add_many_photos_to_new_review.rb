class AddManyPhotosToNewReview < ActiveRecord::Migration
  def change
    add_column :new_reviews, :photo2, :string

    add_column :new_reviews, :photo3, :string

    add_column :new_reviews, :photo4, :string

    add_column :new_reviews, :photo5, :string

    add_column :new_reviews, :photo6, :string

    add_column :new_reviews, :photo7, :string

    add_column :new_reviews, :photo8, :string

    add_column :new_reviews, :photo9, :string

    add_column :new_reviews, :photo10, :string

  end
end
