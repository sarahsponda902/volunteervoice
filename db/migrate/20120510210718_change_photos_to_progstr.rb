class ChangePhotosToProgstr < ActiveRecord::Migration
  def up
    add_column :blog_images, :image, :string
    remove_column :blog_images, :image_file_name
    remove_column :blog_images, :image_content_type
    remove_column :blog_images, :image_file_size
    remove_column :blog_images, :image_updated_at
    add_column :blog_posts, :image, :string
    remove_column :blog_posts, :image_file_name
    remove_column :blog_posts, :image_content_type
    remove_column :blog_posts, :image_file_size
    remove_column :blog_posts, :image_updated_at
    add_column :organizations, :image, :string
    remove_column :organizations, :image_file_name
    remove_column :organizations, :image_content_type
    remove_column :organizations, :image_file_size
    remove_column :organizations, :image_updated_at
    
    add_column :new_reviews, :photo, :string
    remove_column :new_reviews, :photo_file_name
    remove_column :new_reviews, :photo_content_type
    remove_column :new_reviews, :photo_file_size
    remove_column :new_reviews, :photo_updated_at
    add_column :programs, :photo, :string
    remove_column :programs, :photo_file_name
    remove_column :programs, :photo_content_type
    remove_column :programs, :photo_file_size
    add_column :programs, :chart, :string
    remove_column :programs, :chart_file_name
    remove_column :programs, :chart_content_type
    remove_column :programs, :chart_file_size

    add_column :reviews, :photo, :string
    remove_column :reviews, :photo_file_name
    remove_column :reviews, :photo_content_type
    remove_column :reviews, :photo_file_size

    add_column :users, :photo, :string
    remove_column :users, :photo_file_name
    remove_column :users, :photo_content_type
    remove_column :users, :photo_file_size

  end

  def down
  end
end
