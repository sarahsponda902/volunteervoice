class Review < ActiveRecord::Base
  
  
validates :terms, :acceptance => {:accept => true}
validates :organization_id, :presence => true
validates :program_id, :presence => true
validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 
characters."
validates_length_of :body, :maximum => 10000, :message => "You have entered more than 10,000 characters"
belongs_to :program
belongs_to :user



attr_accessible :user_id, :program_id, :body, :rating, :photo, :show, :organization_id, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, :photo2, :photo3, :photo4, :photo5, :photo6, :photo7, :photo8, :photo9, :photo10, :organization_name

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

def self.photos
  photos = []
  photos << self.photo unless self.photo.nil?
  photos << self.photo2 unless self.photo2.nil?
  photos << self.photo3 unless self.photo3.nil?
  photos << self.photo4 unless self.photo4.nil?
  photos << self.photo5 unless self.photo5.nil?
  photos << self.photo6 unless self.photo6.nil?
  photos << self.photo7 unless self.photo7.nil?
  photos << self.photo8 unless self.photo8.nil?
  photos << self.photo9 unless self.photo9.nil?
  photos << self.photo10 unless self.photo10.nil?
  return photos
end


end
