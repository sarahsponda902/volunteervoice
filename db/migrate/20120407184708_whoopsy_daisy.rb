class WhoopsyDaisy < ActiveRecord::Migration
  def up
    remove_column :blog_posts, :blog_type
    add_column :blog_posts, :blog_type, :integer
    remove_column :blog_posts, :blog_link
    add_column :blog_posts, :blog_link, :string, :default => nil
  end
end
