class BlogTag < ActiveRecord::Base
	unloadable

	belongs_to :blog_post
	
	searchable do
	  string :tag
	  boolean :is_our_blog
  end
end