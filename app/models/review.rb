class Review < ActiveRecord::Base
validates :terms, :acceptance => {:accept => true}
validates :organization_id, :presence => true
validates :program_id, :presence => true
validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 
characters."
validates_length_of :body, :maximum => 10000, :message => "You have entered more than 10,000 characters"
belongs_to :program
belongs_to :user
before_create :image_save
validates_file_extension_of :photo, :allowed => ["jpg", "png", "jpeg", "gif"], :message => "must have one of the following extensions: jpg, jpeg, png, gif"
validates_file_size_of :photo, :less_than => 1 * 1024 * 1024, :message => "must be no more than 1024x1024"


attr_accessible :user_id, :program_id, :body, :rating, :photo, :show, :organization_id, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall

# Paperclip
mount_uploader :photo, ImageUploader

def image_save
  AWS::S3::S3Object.store(self.id.to_s+"_review.jpg", open(self.photo.path), "volunteervoice_uncropped", :access => :public_read)
  self.photo = "https://s3.amazonaws.com/volunteervoice_uncropped/#{self.id.to_s}_review.jpg"
end
		
		
    def roundup(overall)
        (overall*2).round / 2.0
    end

end
