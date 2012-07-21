class AddCroppiesToBlogPosts < ActiveRecord::Migration
  def up
    add_column :blog_posts, :crop_h, :integer
    add_column :blog_posts, :crop_w, :integer
  end
end
