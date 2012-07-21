class RemoveBlogTypeFromBlogPost < ActiveRecord::Migration
  def up
    remove_column :blog_posts, :blog_type
      end

  def down
    add_column :blog_posts, :blog_type, :string
  end
end
