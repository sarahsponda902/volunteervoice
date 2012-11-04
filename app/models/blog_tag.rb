# == Schema Information
#
# Table name: blog_tags
#
#  id           :integer          not null, primary key
#  blog_post_id :integer
#  tag          :string(255)      not null
#  is_our_blog  :boolean
#

class BlogTag < ActiveRecord::Base
	unloadable

	belongs_to :blog_post
	
	searchable do
	  string :tag
	  boolean :is_our_blog
  end
end
