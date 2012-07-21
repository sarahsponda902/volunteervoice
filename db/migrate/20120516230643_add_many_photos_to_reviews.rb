class AddManyPhotosToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :photo2, :string

    add_column :reviews, :photo3, :string

    add_column :reviews, :photo4, :string

    add_column :reviews, :photo5, :string

    add_column :reviews, :photo6, :string

    add_column :reviews, :photo7, :string

    add_column :reviews, :photo8, :string

    add_column :reviews, :photo9, :string

    add_column :reviews, :photo10, :string

  end
end
