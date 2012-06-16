class NewReview < ActiveRecord::Base
  validates :terms, :acceptance => {:accept => true}
  validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 
  characters."
  
  belongs_to :user

  attr_accessible :body, :rating, :photo, :show, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, :user_id, :organization, :program, :photo2, :photo3, :photo4, :photo5, :photo6, :photo7, :photo8, :photo9, :photo10

  before_save :change_file_name
  # Paperclip
mount_uploader :photo, ImageUploader


      def roundup(overall)
          (overall*2).round / 2.0
      end
      
      def change_file_name 
        if self.photo 
          @name ||= Digest::MD5.hexdigest(File.dirname(self.photo.url))
          self.photo = "#{@name}.#{file.extension}"
        end
      end
end
