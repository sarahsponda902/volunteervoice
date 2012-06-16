class NewReview < ActiveRecord::Base
  validates :terms, :acceptance => {:accept => true}
  validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 
  characters."
  
  belongs_to :user

  attr_accessible :body, :rating, :photo, :show, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, :user_id, :organization, :program, :photo2, :photo3, :photo4, :photo5, :photo6, :photo7, :photo8, :photo9, :photo10


  # Paperclip
  mount_uploader :photo, ImageUploader
  mount_uploader :photo2, ImageUploader
  mount_uploader :photo3, ImageUploader
  mount_uploader :photo4, ImageUploader
  mount_uploader :photo5, ImageUploader
  mount_uploader :photo6, ImageUploader
  mount_uploader :photo7, ImageUploader
  mount_uploader :photo8, ImageUploader
  mount_uploader :photo9, ImageUploader
  mount_uploader :photo10, ImageUploader


      def roundup(overall)
          (overall*2).round / 2.0
      end
      
      
end
