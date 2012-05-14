class ChangeBlogPostTable < ActiveRecord::Migration
  def up
    remove_column :blog_posts, :blog_type
    add_column :blog_posts, :blog_type, :boolean
  end
end
