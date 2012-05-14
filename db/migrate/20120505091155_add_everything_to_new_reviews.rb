class AddEverythingToNewReviews < ActiveRecord::Migration
  def change
    add_column :new_reviews, :body, :text

    add_column :new_reviews, :user_id, :integer

    add_column :new_reviews, :time_frame, :integer

    add_column :new_reviews, :before, :boolean

    add_column :new_reviews, :terms, :boolean

    add_column :new_reviews, :preparation, :decimal

    add_column :new_reviews, :support, :decimal

    add_column :new_reviews, :impact, :decimal

    add_column :new_reviews, :structure, :decimal

    add_column :new_reviews, :overall, :decimal

  end
end
