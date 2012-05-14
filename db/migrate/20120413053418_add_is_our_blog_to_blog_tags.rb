class AddIsOurBlogToBlogTags < ActiveRecord::Migration
  def change
    add_column :blog_tags, :is_our_blog, :boolean

  end
end
