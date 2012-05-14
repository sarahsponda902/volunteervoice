class BlogImage < ActiveRecord::Base	
	unloadable

	belongs_to :blog_post
	
	validates_file_extension_of :image, :allowed => ["jpg", "png", "jpeg", "gif"], :message => "must have one of the following extensions: jpg, jpeg, png, gif"
	validates_file_size_of :image, :less_than => 1 * 1024 * 1024, :message => "must be no more than 1024x1024"

	attr_accessor :random_id

	# Check for paperclip
  has_file :image, PhotoUploader

end