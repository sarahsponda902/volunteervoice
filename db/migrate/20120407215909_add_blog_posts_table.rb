class AddBlogPostsTable < ActiveRecord::Migration
  def up
    create_table :blog_posts do |t|
      t.string :title
      t.text :body
      t.datetime :created_at
      t.datetime :updated_at
      t.boolean :published
      t.integer :user_id
      t.datetime :published_at
      t.string :image_file_name
      t.string :image_content_type
      t.datetime :image_updated_at
      t.string :blog_link
      t.string :blog_type
      t.integer :crop_x
      t.integer :crop_y
      t.integer :crop_x2
      t.integer :crop_y2
    end
  end
end
