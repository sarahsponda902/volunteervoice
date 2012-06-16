class BlogImage < ActiveRecord::Base	
	unloadable

	belongs_to :blog_post
	after_save :change_file_name
	attr_accessor :random_id

	# Check for paperclip
  mount_uploader :image, ImageUploader

  def change_file_name 
    if self.image 
      @name ||= Digest::MD5.hexdigest(self.image.original_filename)
      self.image.original_filename = "#{@name}.#{file.extension}"
      self.image.save
    end
  end
end