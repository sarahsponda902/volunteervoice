# == Schema Information
#
# Table name: blog_posts
#
#  id                        :integer          not null, primary key
#  title                     :string(255) 
#  body                      :text
#  created_at                :datetime
#  updated_at                :datetime
#  published                 :boolean
#  user_id                   :integer
#  published_at              :datetime
#  blog_link                 :string(255)
#  crop_x                    :integer
#  crop_y                    :integer
#  crop_x2                   :integer
#  crop_y2                   :integer
#  square_image_file_name    :string(255)
#  square_image_content_type :string(255)
#  square_image_file_size    :integer
#  square_image_updated_at   :datetime
#  is_our_blog               :boolean
#  blog_type                 :boolean
#  crop_h                    :integer
#  crop_w                    :integer
#  thumbnail                 :boolean
#  source_title              :string(255)
#  source                    :string(255)
#  image                     :string(255)
#  square_image              :string(255)
#  truncated125              :text
#  truncated100              :text
#



#######################################################################
### Written (mostly) Ryan Stout                                   #####
### in blog_kit plugin at:  https://github.com/ryanstout/blog_kit #####
#######################################################################

class BlogPost < ActiveRecord::Base
  include BlogKitModelHelper
  require 'file_size_validator'
  include CarrierWave::MiniMagick

  unloadable
  
  attr_accessible :blog_type, :image, :body, :title, :tags, :published, :g, :blog_link, :is_our_blog, 
  :square_image, :thumbnail, :crop_x, :crop_y, :crop_h, :crop_w, :source_title, :source  
  attr_accessor  :crop_x, :crop_y, :crop_h, :crop_w
  
  # callbacks
  validates :image, :file_size => {:maximum => 0.5.megabytes.to_i}
  validates_presence_of :title, :body
  validate :photo_presence_article, :photo_width
  before_save :check_published, :save_tags, :square_image_crop, :parse_body

  # associations
  belongs_to :user
  has_many :blog_comments, :dependent => :destroy
  has_many :blog_tags, :dependent => :destroy
  has_many :blog_images, :dependent => :destroy
  
  # scopes
  scope :published, { :conditions => {:published => true, :blog_link => "" }}

  # Sunspot search block
  searchable do
    text :body
    string :title
    string :source_title
    string :source            
    string :blog_link
    boolean :is_our_blog
  end

  # carrierwave uploader
  mount_uploader :image, ImageUploader
  mount_uploader :square_image, ImageUploader #square_image is the smaller, cropped image


  ##### callback methods #####
  
  # validate photo width < 700 pixels
  # to ensure cropping is not skewed 
  # (if image can't fit on page, it will be smaller than actual and mess up the crop parameters)
  def photo_width
    if image.present? && image.url.present?
      @photo = MiniMagick::Image.open(image.url)
      if @photo['width'] > 700
        errors.add(:image, "must have a width of less than 700 pixels")
        return false
      end
    end
  end

  # validates presence of image (only for article/interesting posts)
  def photo_presence_article 
    if !is_our_blog && (image.nil? || image.url.nil?)
      errors.add(:image, "must be present for an article post")
      return false
    end
  end
  
  # crops the image to be 3:1 ratio given the parameters from /blog_posts/:id/crop
  def square_image_crop
    if self.crop_x.present? && self.crop_y.present? && self.crop_w.present? && self.crop_h.present?
      @image = MiniMagick::Image.open(self.image.url)
      @image.crop("#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}")
      
      # remove black space around cropped image (if any)
      @image.set("page", "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}")
      
      self.square_image = @image
    end
  end

  # convert blog_post body to RedCloth textile format => html
  def parse_body
    self.body = RedCloth.new(body).to_html
  end
  
  def save_tags
    if @tags
      # Remove old tags
      self.blog_tags.delete_all

      # Save new tags
      @tags.split(/,/).each do |tag|
        self.blog_tags.build(:tag => tag.strip.downcase)
      end
    end
  end



  ####### Other Methods #######
  
  # returns all blog_post's tags
  def tags
    @tags ||= self.blog_tags.map(&:tag).join(', ')
  end

  def tags=(tags)
    @tags = tags
  end

  def formatted_updated_at
    self.updated_at.strftime(BlogKit.instance.settings['post_date_format'] || '%m/%d/%Y at %I:%M%p')
  end

  # Provide SEO Friendly URL's
  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end


end
