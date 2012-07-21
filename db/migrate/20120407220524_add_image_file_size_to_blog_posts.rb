class AddImageFileSizeToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :image_file_size, :integer

  end
end
