# == Schema Information
#
# Table name: organizations
#
#  id                           :integer          not null, primary key
#  name                         :string(255)
#  description                  :text
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  program_id                   :integer
#  show                         :boolean
#  page_views                   :integer
#  overall                      :decimal(, )
#  num_reviews                  :integer
#  email                        :string(255)
#  operating_since              :integer
#  good_to_know                 :text
#  reviews_count                :integer
#  training_resources           :text
#  url                          :string(255)
#  volunteer_program_model      :text
#  image                        :string(255)
#  id_number                    :string(255)
#  square_image                 :string(255)
#  crop_x                       :integer
#  crop_y                       :integer
#  crop_w                       :integer
#  crop_h                       :integer
#  phone                        :string(255)
#  truncated75                  :text
#  misson                       :text
#  program_costs_includes       :text
#  program_model_string         :string(255)
#  business_model               :string(255)
#  run_by                       :string(255)
#  price_ranges                 :string(255)
#  program_costs_doesnt_include :text
#  headquarters_location        :text
#  types_of_programs            :string(255)
#  invite_email                 :string(255)
#  will_invite                  :boolean
#  published_docs               :boolean
#  additional_fees              :string(255)
#  full_time_staff              :integer
#  num_vols_yr                  :string(255)
#  num_vols_date                :string(255)
#  application_process          :text
#  price_breakdown              :text
#  crops                        :boolean
#

class Organization < ActiveRecord::Base
  require 'file_size_validator'
  include CarrierWave::MiniMagick

  # associations
  has_many :program_cost_length_maps, :through => :programs
  has_many :program_sizes, :through => :programs
  has_many :program_subjects, :through => :programs
  has_many :reviews, :through => :programs
  has_many :programs, :dependent => :destroy
  has_one :organization_account, :dependent => :destroy
  
  # attributes
  attr_accessible :image, :name, :description, :show, :overall, :num_reviews, :program_id, :page_views, :misson, :phone, :email, :operating_since, :num_vols_date, :num_vols_yr, :application_process, :business_model, :program_model_string, :good_to_know, :reviews_count, :trining_resources, :price_ranges, :program_costs_breakdown, :program_costs_includes, :url, :run_by, :id_number, :volunteer_program_model, :price_ranges, :training_resources, :crop_x, :crop_y, :crop_w, :crop_h, :square_image, :program_costs_doesnt_include, :price_breakdown, :headquarters_location, :types_of_programs, :will_invite, :invite_email, :published_docs, :additional_fees, :full_time_staff, :crops
  
  # callbacks
  validates_presence_of :image
  validates_uniqueness_of :name
  validates :image, :file_size => {:maximum => 0.5.megabytes.to_i}
  before_save :add_http_to_url
  before_save :square_image_crop
  before_save :textilize_textareas
  before_create :set_page_views_to_zero

  # scopes
  scope :random, :order=>'RAND()', :limit=>1

  # Carrierwave uploaders
  mount_uploader :image, ImageUploader
  mount_uploader :square_image, ImageUploader

  # Sunspot search block
  searchable do
    text :name
    string :business_model
    text :program_costs_includes
  end


  ###### callback methods ######
  
  # set initial # of organization's page views to zero
  def set_page_views_to_zero
    self.page_views = 0
  end
  
  # crop image to be square
  def square_image_crop
    if self.crop_x.present? && self.crop_y.present? && self.crop_w.present? && self.crop_h.present?
      image = MiniMagick::Image.open(self.image.url)
      # if image is too big, resize it before showing on crop page
      # this is to ensure that cropping isn't messed up by the crop selector not being in the right place
      if image[:width] > 700
        resize_scale = (700/image[:width].to_f) * 100
        image.sample(resize_scale.to_s + "%")
      end
      image.crop("#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}")
      
      # get rid of extra black border space
      image.set("page", "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}") 
      
      self.square_image = image
    end
  end

  # add http:// to url if none exists
  #   for "open in new tab" functionality on page
  def add_http_to_url
    if self.url[0..3] != "http"
      self.url = "http://"+self.url
    end
  end
  
  # textilize all textareas to retain newlines, formatting, etc.
  def textilize_textareas
    self.description = textilized( untextilized(self.description) )
    self.headquarters_location = textilized( untextilized(self.headquarters_location) )
    self.good_to_know = textilized( untextilized(self.good_to_know) )
    self.training_resources = textilized( untextilized(self.training_resources) )
    self.misson = textilized( untextilized(self.misson) )
    self.program_costs_includes = textilized( untextilized(self.program_costs_includes) )
    self.program_costs_doesnt_include = textilized( untextilized(self.program_costs_doesnt_include) )
    self.price_breakdown = textilized( untextilized(self.price_breakdown) )
    self.application_process = textilized( untextilized(self.application_process) )
  end
  
  
  
  ###### Other methods ######
  
  # for un-textilizing textile/html text
  # so that it can be edited without the html tags in a textarea box
  def untextilized(textile)
    return Nokogiri::HTML.fragment(textile).text
  end

  # for textilizing plain text from a textarea box
  # so that newlines and formatting are preserved
  def textilized(text)
    return RedCloth.new( ActionController::Base.helpers.sanitize( text ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
  end
  
  # textilize methods for best_in_place in-place editing on organization's profile
  # (in-place editing of organization profile is only for org accounts and admins)
  def textilize_misson
    textilize(misson).html_safe
  end

  def textilize_headquarters_address
    textilize(headquarters_location).html_safe
  end

  def textilize_application_process
    textilize(application_process).html_safe
  end

  def textilize_program_costs_includes
    textilize(program_costs_includes).html_safe
  end

  def textilize_program_costs_doesnt_include
    textilize(program_costs_doesnt_include).html_safe
  end

  def textilize_training_resources
    textilize(training_resources).html_safe
  end

  # returns the last created review
  def latest_review_time
    if !(reviews.empty? || reviews.last.nil?)
      reviews.last.created_at
    else
      20.years.ago
    end
  end

  # rounds the overall review score up
  def roundup(overall)
    if overall.nil?
      0
    else
      (overall*2).round / 2.0
    end
  end

end
