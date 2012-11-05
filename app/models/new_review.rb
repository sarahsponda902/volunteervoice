# == Schema Information
#
# Table name: new_reviews
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  body         :text
#  user_id      :integer
#  before       :boolean
#  terms        :boolean
#  preparation  :decimal(, )
#  support      :decimal(, )
#  impact       :decimal(, )
#  structure    :decimal(, )
#  overall      :decimal(, )
#  organization :string(255)
#  program      :string(255)
#  time_frame   :string(255)
#  photo        :string(255)
#  truncated100 :text
#  photo2       :string(255)
#  photo3       :string(255)
#  photo4       :string(255)
#  photo5       :string(255)
#  photo6       :string(255)
#  photo7       :string(255)
#  photo8       :string(255)
#  photo9       :string(255)
#  photo10      :string(255)
#  admin_read   :boolean          default(FALSE)
#

class NewReview < ActiveRecord::Base
  require 'file_size_validator'

  # associations
  belongs_to :user

  # callbacks
  validates :terms, :acceptance => {:accept => true}
  validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 characters."
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

  # attributes
  attr_accessible :body, :rating, :photo, :show, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, :user_id, :organization, :program, :photo2, :photo3, :photo4, :photo5, :photo6, :photo7, :photo8, :photo9, :photo10


  # Carrierwave uploaders
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


  ### Other methods ###
  def roundup(overall)
    (overall*2).round / 2.0
  end


end
