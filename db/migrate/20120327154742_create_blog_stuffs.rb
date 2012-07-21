class CreateBlogStuffs < ActiveRecord::Migration
  def up
    create_table :blog_comments do |t|
			t.column :blog_post_id, :integer
			t.column :user_id, :integer
			t.column :user_ip, :string
			t.column :user_agent, :string
			t.column :referrer, :string
			t.column :name, :string
			t.column :site_url, :string
			t.column :email, :string
			t.column :body, :text
			t.column :created_at, :datetime
    end

    add_index :blog_comments, :blog_post_id
    
    create_table :blog_images, :force => true do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.integer :blog_post_id
      t.timestamps
    end

    add_index :blog_images, :blog_post_id
    
    create_table :blog_posts do |t|
			t.column :title, :string, :null => false
			t.column :body, :text
			t.column :created_at, :datetime
			t.column :updated_at, :datetime
			t.column :published, :boolean, :null => false, :default => false
			t.column :user_id, :integer
			t.column :published_at, :datetime
			
			create_table :blog_tags do |t|
  			t.column :blog_post_id, :integer
  			t.column :tag, :string, :null => false
      end

      add_index :blog_tags, :blog_post_id
      add_index :blog_tags, :tag
    end
  end

  def down
  end
end
