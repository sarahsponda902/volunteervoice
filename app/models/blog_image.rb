# == Schema Information
#
# Table name: blog_images
#
#  id           :integer          not null, primary key
#  blog_post_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :string(255)
#


#######################################################################
### Written (mostly) Ryan Stout                                   #####
### in blog_kit plugin at:  https://github.com/ryanstout/blog_kit #####
#######################################################################

class BlogImage < ActiveRecord::Base
  include CarrierWave::MiniMagick
  require 'file_size_validator'
  unloadable

  belongs_to :blog_post
  validates :image, :file_size => {:maximum => 0.5.megabytes.to_i}
  attr_accessor :random_id

  # Uploader (carrierwave)
  mount_uploader :image, ImageUploader


end
