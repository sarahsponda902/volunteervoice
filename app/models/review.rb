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
  attr_accessible :user_id, :program_id, :body, :rating, :photo, :show, :organization_id, 
  :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, 
  :photo2, :photo3, :photo4, :photo5, :photo6, :photo7, :photo8, :photo9, :photo10, :organization_name

  # callbacks
  validates :terms, :acceptance => {:accept => true}
  validates :program_id, :presence => true
  validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 characters."
  validates_length_of :body, :maximum => 10000, :message => "You have entered more than 10,000 characters"
  validates_inclusion_of :organization_name, :in => Organization.all.map(&:name)
  [nil, 2, 3, 4, 5, 6, 7, 8, 9, 10].each do |num|
      validates "photo#{num}".to_sym, :file_size => {:maximum => 0.5.megabytes.to_i}
  end
  before_create :resize_review_photos
  
  # Carrierwave uploaders
  [nil, 2, 3, 4, 5, 6, 7, 8, 9, 10].each do |num|
    mount_uploader "photo#{num}".to_sym, ImageUploader
  end


###### callback methods #######

  def resize_review_photos
    [nil, 2, 3, 4, 5, 6, 7, 8, 9, 10].each do |num|
      self.instance_variable_set("photo#{num}",resize_photos_helper(self.send("photo#{num}")))
    end
  end
  
  
###### helper methods #######

# returns photo that is scaled to be smaller than 300x600px
# returns nil if photo.blank?
  def resize_photos_helper(photo)
    return nil if photo.blank?
    image = MiniMagick::Image.open(self.photo.url)
    [[:height,300], [:width, 600]].each do |param, num|
      if image.send(param) > num 
        scaling_percent = (num / image.send(param).to_f)*100
        image.sample(scaling_percent.to_s + "%")
      end
    end
    return image
  end


end
