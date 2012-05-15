class NewReview < ActiveRecord::Base
  validates :terms, :acceptance => {:accept => true}
  validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 
  characters."
  
  belongs_to :user
  
  validates_file_extension_of :photo, :allowed => ["jpg", "png", "jpeg", "gif"], :message => "must have one of the following extensions: jpg, jpeg, png, gif"
	validates_file_size_of :photo, :less_than => 1 * 1024 * 1024, :message => "must be no more than 1024x1024"
	before_create :image_save

  attr_accessible :body, :rating, :photo, :show, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, :user_id, :organization, :program

  # Paperclip



      def roundup(overall)
          (overall*2).round / 2.0
      end
  
      def image_save
        AWS::S3::S3Object.store(self.id.to_s+"_new_review.jpg", open(self.photo.path), "volunteervoice_uncropped", :access => :public_read)
            self.photo = "https://s3.amazonaws.com/volunteervoice_uncropped/#{self.id.to_s}_new_review.jpg"
      end
  
end
