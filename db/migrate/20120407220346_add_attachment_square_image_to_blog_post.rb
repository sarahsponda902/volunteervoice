class AddAttachmentSquareImageToBlogPost < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :square_image_file_name, :string
    add_column :blog_posts, :square_image_content_type, :string
    add_column :blog_posts, :square_image_file_size, :integer
    add_column :blog_posts, :square_image_updated_at, :datetime
  end

  def self.down
    remove_column :blog_posts, :square_image_file_name
    remove_column :blog_posts, :square_image_content_type
    remove_column :blog_posts, :square_image_file_size
    remove_column :blog_posts, :square_image_updated_at
  end
end
