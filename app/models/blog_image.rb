class BlogImage < ActiveRecord::Base
  	include CarrierWave::MiniMagick
  	
	unloadable

	belongs_to :blog_post
  validate :validate_image_size
	attr_accessor :random_id

	# Check for paperclip
  mount_uploader :image, ImageUploader

  def validate_image_size
    image = MiniMagick::Image.open(self.image.path)
    unless image[:width] < 700 && image[:height] < 700
      errors.add :image, "must be smaller than 700x700 px" 
    end
  end
end