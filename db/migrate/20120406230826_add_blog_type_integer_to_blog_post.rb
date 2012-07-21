class AddBlogTypeIntegerToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :blog_type, :integer

  end
end
