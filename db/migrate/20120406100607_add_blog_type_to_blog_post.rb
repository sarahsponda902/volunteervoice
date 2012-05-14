class AddBlogTypeToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :blog_type, :string

  end
end
