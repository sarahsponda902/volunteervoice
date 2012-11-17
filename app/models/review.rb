# == Schema Information
#
# Table name: reviews
#
#  id                :integer          not null, primary key
#  body              :text
#  program_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  show              :boolean
#  organization_id   :integer
#  before            :boolean
#  terms             :boolean
#  preparation       :decimal(, )
#  support           :decimal(, )
#  impact            :decimal(, )
#  structure         :decimal(, )
#  overall           :decimal(, )
#  time_frame        :string(255)
#  photo             :string(255)
#  organization_name :string(255)
#  photo2            :string(255)
#  photo3            :string(255)
#  photo4            :string(255)
#  photo5            :string(255)
#  photo6            :string(255)
#  photo7            :string(255)
#  photo8            :string(255)
#  photo9            :string(255)
#  photo10           :string(255)
#  truncated100      :text
#  truncated200      :text
#  flag_show         :boolean
#  admin_read        :boolean          default(FALSE)
#

class Review < ActiveRecord::Base
  include CarrierWave::MiniMagick

  # associations
  belongs_to :program
  belongs_to :user
  has_many :flags, :dependent => :destroy
  
  # attributes
  attr_accessible :user_id, :program_id, :body, :rating, :photo, :show, :organization_id, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, :photo2, :photo3, :photo4, :photo5, :photo6, :photo7, :photo8, :photo9, :photo10, :organization_name

  # callbacks
  validates :terms, :acceptance => {:accept => true}
  validates :program_id, :presence => true
  validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 characters."
  validates_length_of :body, :maximum => 10000, :message => "You have entered more than 10,000 characters"
  validates_inclusion_of :organization_name, :in => Organization.all.map(&:name)
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
  before_create :resize_review_photos
  
  # Carrierwave image uploaders
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


###### callback methods #######

  def resize_review_photos
    self.photo = resize_photos_helper(photo)
    self.photo2 = resize_photos_helper(photo2)
    self.photo3 = resize_photos_helper(photo3)
    self.photo4 = resize_photos_helper(photo4)
    self.photo5 = resize_photos_helper(photo5)
    self.photo6 = resize_photos_helper(photo6)
    self.photo7 = resize_photos_helper(photo7)
    self.photo8 = resize_photos_helper(photo8)
    self.photo9 = resize_photos_helper(photo9)
    self.photo10 = resize_photos_helper(photo10)
  end
  
  
###### helper methods #######

# returns photo that is scaled to be smaller than 300x600px
# returns nil if photo.blank?
  def resize_photos_helper(photo)
    if !photo.blank?
      image = MiniMagick::Image.open(self.photo.url)
      if image[:height] > 300
        scaling_height_percent = (300 / image[:height].to_f)*100
        image.sample(scaling_height_percent.to_s + "%")
      end  
      if image[:width] > 600
        scaling_width_percent = (600 / image[:width].to_f)*100
        image.sample(scaling_width_percent.to_s + "%")
      end
      return image
    else
      return nil
    end
  end


end
