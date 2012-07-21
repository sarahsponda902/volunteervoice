class AddIsOurBlogToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :is_our_blog, :boolean

  end
end
