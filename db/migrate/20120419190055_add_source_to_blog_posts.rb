class AddSourceToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :source_title, :string

    add_column :blog_posts, :source, :string

  end
end
