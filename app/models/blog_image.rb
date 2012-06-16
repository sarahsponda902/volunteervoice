class BlogImage < ActiveRecord::Base	
	unloadable

	belongs_to :blog_post
	before_save :change_file_name
	attr_accessor :random_id

	# Check for paperclip
  mount_uploader :image, ImageUploader

  def change_file_name 
    if self.image 
      @name ||= Digest::MD5.hexdigest(File.basename(self.image.url))
      self.image = "#{@name}.#{file.extension}"
    end
  end
end