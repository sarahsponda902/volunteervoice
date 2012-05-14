class RemoveSquareImageStuff < ActiveRecord::Migration
  def up
     add_column :blog_posts, :square_image, :string
      remove_column :blog_posts, :square_image_file_name
      remove_column :blog_posts, :square_image_content_type
      remove_column :blog_posts, :square_image_file_size
      remove_column :blog_posts, :square_image_updated_at
  end

  def down
  end
end
