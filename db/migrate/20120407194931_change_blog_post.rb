class ChangeBlogPost < ActiveRecord::Migration
  def up
    remove_column :blog_posts, :is_our_blog
    add_column :blog_posts, :is_our_blog, :boolean, :default => true
  end
end
