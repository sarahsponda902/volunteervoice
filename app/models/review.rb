class Review < ActiveRecord::Base
require 'file_size_validator'
  include CarrierWave::MiniMagick
@orgs = []
Organization.find_each do |f|
  @orgs << f.name
end
validates :terms, :acceptance => {:accept => true}
validates :program_id, :presence => true
validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 characters."
validates_length_of :body, :maximum => 10000, :message => "You have entered more than 10,000 characters"
validates_inclusion_of :organization_name, :in => @orgs
validates :photo, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo2, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo3, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo4, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo5, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo6, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo7, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo8, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo9, :file_size => {:maximum => 0.5.megabytes.to_i}
validates :photo10, :file_size => {:maximum => 0.5.megabytes.to_i}
belongs_to :program
belongs_to :user
has_many :flags, :dependent => :destroy
before_create :resize_review_photos




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



end
