class AddTruncatedToLotsOStuff < ActiveRecord::Migration
  def change
    add_column :blog_posts, :truncated125, :text
    add_column :blog_posts, :truncated100, :text
    add_column :feedbacks, :truncated100, :text
    add_column :new_reviews, :truncated100, :text
    add_column :organizations, :truncated75, :text
    add_column :programs, :truncated_description100, :text
    add_column :reviews, :truncated100, :text
    add_column :reviews, :truncated200, :text
  end
end
