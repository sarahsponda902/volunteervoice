class AddThumbnailToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :thumbnail, :boolean

  end
end
