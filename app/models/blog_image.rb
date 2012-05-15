class BlogImage < ActiveRecord::Base	
	unloadable

	belongs_to :blog_post
	
	attr_accessor :random_id

	# Check for paperclip
  mount_uploader :image, ImageUploader

end