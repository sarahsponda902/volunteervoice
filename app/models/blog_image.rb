class BlogImage < ActiveRecord::Base
  	include CarrierWave::MiniMagick
  	
	unloadable

	belongs_to :blog_post
   validates :image, :file_size => {:maximum => 0.5.megabytes.to_i}
	attr_accessor :random_id

	# Check for paperclip
  mount_uploader :image, ImageUploader

  
end