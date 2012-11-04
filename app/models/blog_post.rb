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

class BlogPost < ActiveRecord::Base
	include BlogKitModelHelper
	require 'file_size_validator'
	include CarrierWave::MiniMagick

	unloadable
  validates :image, :file_size => {:maximum => 0.5.megabytes.to_i}
  attr_accessible :blog_type, :image, :body, :title, :tags, :published, :g, :blog_link, :is_our_blog, :square_image, :thumbnail, :crop_x, :crop_y, :crop_h, :crop_w, :source_title, :source
  attr_accessor  :crop_x, :crop_y, :crop_h, :crop_w

	belongs_to :user

	has_many :blog_comments, :dependent => :destroy
	has_many :blog_tags, :dependent => :destroy
	has_many :blog_images, :dependent => :destroy
	
	searchable do
	  
    text :body
    string :title
    string :source_title
    string :source            
    string :blog_link
    boolean :is_our_blog
  end


	validates_presence_of :title
	validates_presence_of :body
	before_save :validate_photo_presence_article
	
	

	scope :published, { :conditions => {:published => true, :blog_link => "" }}
	scope :drafts, { :conditions => {:published => false }}

	before_save :check_published, :if => :not_resaving?
	before_save :save_tags, :if => :not_resaving?
	before_save :square_image_crop

  before_save :validate_photo_width
	before_save :parse_body
	
	mount_uploader :image, ImageUploader
	mount_uploader :square_image, ImageUploader

  
  def validate_photo_width
    if !(image.nil?) && !(image.url.nil?)
      @photo = MiniMagick::Image.open(image.url)
      if @photo['width'] > 700
        errors.add(:image, "must have a width of less than 700 pixels")
        return false
      end
    end
  end
  
  def validate_photo_presence_article 
    if !is_our_blog
      if image.nil? || image.url.nil?
        errors.add(:image, "must be present for an article post")
        return false
      end
    end
  end
  
  def parse_body
    self.body = RedCloth.new(body).to_html
  end

	def tags
		@tags ||= self.blog_tags.map(&:tag).join(', ')
	end

	def tags=(tags)
		@tags = tags
	end

	def tags_with_links
		html = self.tags.split(/,/).collect {|t| "<a href=\"/blog_posts/tag/#{t.strip}\">#{t.strip}</a>" }.join(', ')
		return html
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

	def not_resaving?
		!@resaving
	end

	def check_published
		if self.published_change && self.published_change == [false, true]
			# Moved to published state, update published_on
			self.published_at = Time.now
		end
	end

	def show_user?
		(!BlogKit.instance.settings['show_user_who_published'] || BlogKit.instance.settings['show_user_who_published'] == true) && self.user
	end


	def user_name(skip_link=false)
		if !skip_link && BlogKit.instance.settings['link_to_user']
			return "<a href=\"/users/#{self.user.id}\">#{CGI.escapeHTML(self.user.name)}</a>"
		else
			return self.user.name
		end
	end


	def formatted_updated_at
		self.updated_at.strftime(BlogKit.instance.settings['post_date_format'] || '%m/%d/%Y at %I:%M%p')
	end

	# Provide SEO Friendly URL's
	def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  def replace_blog_image_tags
  end
  

  def square_image_crop
    if !(self.crop_x.nil? || self.crop_y.nil? || self.crop_w.nil? || self.crop_h.nil?)
      image = MiniMagick::Image.open(self.image.url)
      image.crop("#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}")
      image.set("page", "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}") 
      self.square_image = image
    end
  end

  
end
