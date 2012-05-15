class BlogPost < ActiveRecord::Base
	include BlogKitModelHelper

  require 'open-uri'
  

	unloadable

  attr_accessible :blog_type, :image, :body, :title, :tags, :published, :g, :blog_link, :is_our_blog, :square_image, :thumbnail, :crop_x, :crop_y, :crop_h, :crop_w, :source_title, :source
  attr_accessor  :crop_x, :crop_y, :crop_h, :crop_w

	belongs_to :user

	has_many :blog_comments, :dependent => :destroy
	has_many :blog_tags, :dependent => :destroy
	has_many :blog_images, :dependent => :destroy
	
	searchable do
	  
    text :body
    text :title
    integer :blog_type
    string :blog_link
    boolean :is_our_blog
  end


	validates_presence_of :title
	validates_presence_of :body
	validates_file_extension_of :image, :allowed => ["jpg", "png", "jpeg", "gif"], :message => "must have one of the following extensions: jpg, jpeg, png, gif"
	validates_file_size_of :image, :less_than => 1 * 1024 * 1024, :message => "must be no more than 1024x1024"
	
	

	scope :published, { :conditions => {:published => true, :blog_link => "" }}
	scope :drafts, { :conditions => {:published => false }}

	before_save :check_published, :if => :not_resaving?
	before_save :save_tags, :if => :not_resaving?
	before_save :square_image_crop
	
	
  has_file :image, PhotoUploader
		
	has_file :square_image, PhotoUploader

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
  
  private
  def square_image_crop
    if !(self.crop_x.nil? || self.crop_y.nil? || self.crop_w.nil? || self.crop_h.nil?)
      job = Blitline::Job.new(self.image.url)
      job.application_id = "UUVLpW9l2-s_hzz50zH4oQ"
      crop_function = job.add_function("crop", {:x => self.crop_x, :y => self.crop_y, :width => self.crop_w, :height => self.crop_h})
      crop_function.add_save(self.id+"square")
      blitline_service = Blitline.new
      blitline_service.jobs << job
      url = blitline_service.post_jobs["results"][0]["images"][0]["s3_url"]
      temp = File.new('temp.jpg', 'wb+')
      open('temp.jpg', 'wb+') do |file|
        file << open(url).read
      end
      self.square_image = temp
      self.save
      File.delete('temp.jpg')
    end
  end

  
end