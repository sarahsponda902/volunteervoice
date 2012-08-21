class Organization < ActiveRecord::Base
  require 'file_size_validator'
  include CarrierWave::MiniMagick
  
has_many :program_cost_length_maps, :through => :programs
has_many :program_sizes, :through => :programs
has_many :program_subjects, :through => :programs
has_many :programs, :dependent => :destroy
has_one :organization_account, :dependent => :destroy
attr_accessible :image, :name, :description, :show, :overall, :num_reviews, :program_id, :page_views, :misson, :phone, :email, :operating_since, :num_vols_date, :num_vols_yr, :application_process, :business_model, :program_model_string, :good_to_know, :reviews_count, :trining_resources, :price_ranges, :program_costs_breakdown, :program_costs_includes, :url, :run_by, :id_number, :volunteer_program_model, :price_ranges, :training_resources, :crop_x, :crop_y, :crop_w, :crop_h, :square_image, :program_costs_doesnt_include, :price_breakdown, :headquarters_location, :types_of_programs, :will_invite, :invite_email, :published_docs, :additional_fees, :full_time_staff
validates_presence_of :image


scope :random, :order=>'RAND()', :limit=>1
validates_uniqueness_of :name

before_save :square_image_crop
validates :image, :file_size => {:maximum => 0.5.megabytes.to_i}

before_create :set_page_views_to_zero
  def set_page_views_to_zero
    self.page_views = 0
  end

# Paperclip
    mount_uploader :image, ImageUploader
    mount_uploader :square_image, ImageUploader

# Sunspot Search
searchable do
  text :name
  string :business_model
  text :program_costs_includes
end

def roundup(overall)
    (overall*2).round / 2.0
end

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

def square_image_crop
   if !(self.crop_x.nil? || self.crop_y.nil? || self.crop_w.nil? || self.crop_h.nil?)
     image = MiniMagick::Image.open(self.image.url)
      if image[:width] > 700
        resize_scale = (700/image[:width].to_f) * 100
        image.sample(resize_scale.to_s + "%")
      end
     image.crop("#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}")
     image.set("page", "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}") 
     self.square_image = image
   end
 end
 
 

end
