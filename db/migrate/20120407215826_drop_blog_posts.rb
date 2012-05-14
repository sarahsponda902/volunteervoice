class DropBlogPosts < ActiveRecord::Migration
  def up
    drop_table :blog_posts
  end

end
