class NewReview < ActiveRecord::Base
  validates :terms, :acceptance => {:accept => true}
  validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 
  characters."
  
  belongs_to :user
  
  validates_file_extension_of :photo, :allowed => ["jpg", "png", "jpeg", "gif"], :message => "must have one of the following extensions: jpg, jpeg, png, gif"
	validates_file_size_of :photo, :less_than => 1 * 1024 * 1024, :message => "must be no more than 1024x1024"
	

  attr_accessible :body, :rating, :photo, :show, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, :user_id, :organization, :program

  # Paperclip
  has_file :photo, PhotoUploader


      def roundup(overall)
          (overall*2).round / 2.0
      end
  
  
  
end
