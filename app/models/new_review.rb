class NewReview < ActiveRecord::Base
  validates :terms, :acceptance => {:accept => true}
  validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 
  characters."
  
  belongs_to :user

  attr_accessible :body, :rating, :photo, :show, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, :user_id, :organization, :program

  # Paperclip
mount_uploader :photo, ImageUploader


      def roundup(overall)
          (overall*2).round / 2.0
      end
  
end
