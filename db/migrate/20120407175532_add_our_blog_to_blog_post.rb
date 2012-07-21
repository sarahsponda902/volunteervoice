class AddOurBlogToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :is_our_blog, :boolean, :default => false

  end
end
