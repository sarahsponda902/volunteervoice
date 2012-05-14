class AddBlogLinkToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :blog_link, :string

  end
end
