class BlogPost < ActiveRecord::Base
	include BlogKitModelHelper

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
	before_save :parse_body
	
	
  has_file :image, PhotoUploader
  
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
      crop_params = "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}"
      image.crop(crop_params)
      image.write "tempfile.jpg"
      AWS::S3::S3Object.store(self.id.to_s+"_square.jpg", open("tempfile.jpg"), "volunteervoice_blogsquareimages", :access=>:public_read)
      FileUtils.rm "tempfile.jpg"
      self.square_image = "https://s3.amazonaws.com/volunteervoice_blogsquareimages/#{self.id.to_s}_square.jpg"
    end
  end

  
end