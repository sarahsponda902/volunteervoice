# == Schema Information
#
# Table name: blog_tags
#
#  id           :integer          not null, primary key
#  blog_post_id :integer
#  tag          :string(255)      not null
#  is_our_blog  :boolean
#


#######################################################################
### Written (mostly) Ryan Stout                                   #####
### in blog_kit plugin at:  https://github.com/ryanstout/blog_kit #####
#######################################################################

class BlogTag < ActiveRecord::Base
	unloadable

	belongs_to :blog_post
	
	# Sunspot search block
	searchable do
	  string :tag
	  boolean :is_our_blog
  end
end
