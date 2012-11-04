# == Schema Information
#
# Table name: programs
#
#  id                            :integer          not null, primary key
#  name                          :string(255)
#  description                   :text
#  weekly_cost                   :integer
#  location                      :string(255)
#  organization_id               :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  review_id                     :integer
#  subject                       :string(255)
#  headquarters                  :string(255)
#  overall                       :decimal(, )
#  start_dates                   :string(255)
#  program_structure             :text
#  partnered_local_organizations :string(255)
#  cost_includes                 :text
#  program_cost_breakdown        :text
#  check_it_out                  :string(255)
#  length                        :string(255)
#  group_size                    :string(255)
#  photo                         :string(255)
#  organization_name             :string(255)
#  square_image                  :string(255)
#  crop_x                        :integer
#  crop_y                        :integer
#  crop_w                        :integer
#  crop_h                        :integer
#  chart                         :string(255)
#  truncated_description100      :text
#  program_started               :string(255)
#  cost_doesnt_include           :text
#  url                           :string(255)
#  specific_location             :string(255)
#  location_name                 :string(255)
#  published_docs                :boolean
#  lengths_of_program            :string(255)
#  food_situation                :string(255)
#  program_requirements          :string(255)
#  accommodations                :text
#

class Program < ActiveRecord::Base
  require 'rubygems'
  require 'file_size_validator'
  include CarrierWave::MiniMagick
  
  
belongs_to :organization
has_many :reviews, :dependent => :destroy
has_many :program_subjects, :dependent => :destroy
has_many :program_cost_length_maps, :dependent => :destroy
has_many :program_sizes, :dependent => :destroy
has_many :favorites, :dependent => :destroy
attr_accessible :id, :photo, :name, :description, :weekly_cost, :location, :organization_id, :subject, :group_size, :headquarters, :length, :overall, :chart, :program_started, :start_dates, :program_structure, :partnered_local_organizations, :cost_includes, :cost_doesnt_include, :program_cost_breakdown, :accommodations, :check_it_out, :organization_name, :crop_x, :crop_y, :crop_w, :crop_h, :square_image, :program_subjects, :program_sizes, :specific_location, :location_name, :program_cost_length_maps, :published_docs, :food_situation, :lengths_of_program, :program_requirements
validates_presence_of :name, :description, :location, :organization_id, :program_started, :start_dates, :partnered_local_organizations, :cost_includes, :cost_doesnt_include, :program_cost_breakdown, :accommodations, :program_subjects, :program_sizes, :specific_location, :program_cost_length_maps, :food_situation, :lengths_of_program, :program_requirements
before_save :copy_organization_images_and_program_model
before_save :square_image_crop
before_save :validate_subjects_inclusions
before_save :textilize_textareas
before_save :set_location_name
before_save :set_http
# Paperclip
    mount_uploader :photo, ImageUploader
    mount_uploader :square_image, ImageUploader
# Sunspot Search



searchable do
  text :name
  text :organization_name
  text :location_name
  string :program_subjects, :multiple => true do
    program_subjects.map(&:subject)
  end
  string :weekly_cost
  string :program_sizes, :multiple => true do
    program_sizes.map(&:size)
  end
  string :location
  location :program_cost_length_maps, :multiple => true do
    program_cost_length_maps.map{|p| Sunspot::Util::Coordinates.new(p.length.to_f, p.cost.to_f) }
  end
  text :description
  text :start_dates
  text :program_structure
  text :partnered_local_organizations
  text :cost_includes
  text :accommodations
  text :specific_location
  text :food_situation
  text :program_requirements
  
end



def copy_organization_images_and_program_model
  self.photo = Organization.find(organization_id).image.file
  self.square_image = Organization.find(organization_id).square_image.file
  self.program_structure = Organization.find(organization_id).program_model_string
end


def roundup(overall)
    if overall.nil?
      0
    else
      (overall*2).round / 2.0
    end
end

def square_image_crop
   if !(self.crop_x.nil? || self.crop_y.nil? || self.crop_w.nil? || self.crop_h.nil?)
     image = MiniMagick::Image.open(self.photo.url)
     image.crop("#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}")
     image.set("page", "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}") 
     self.square_image = image
   end
 end
 
 def all_subjects
   ['Agriculture', 
    'Organic Farming', 
    'Sustainable Development', 
    'Animal Care', 
    'Animal Rights', 
    'Wildlife Conservation', 
    'Caregiving', 
    'Elder Care', 
    'Child/Orphan Care', 
    'Disabled Care', 
    'Feed the Homeless', 
    'Community Development', 
    'Youth Development and Outreach', 
    'Construction', 
    'Culture and Community', 
    'Performing Arts', 
    'Fashion', 
    'Music', 
    'Sports & Recreation', 
    'Journalism', 
    'Disaster Relief', 
    'Economics', 
    'Microfinance', 
    'Education', 
    'Teaching English', 
    'Teaching Buddhist Monks', 
    'Teaching Children', 
    'Teaching Computer Literacy', 
    'Engineering and Infrastructure', 
    'Environmental', 
    'Ecological Conservation', 
    'Habitat Restoration', 
    'Health and Medicine', 
    'HIV/AIDS', 
    'Nutrition', 
    'Family Planning', 
    'Veterinary Medicine', 
    'Clinical Work', 
    'Dental Work', 
    'Medical Research', 
    'Health Education', 
    'Public Health', 
    'Hospital Care-giving', 
    'Human Rights', 
    'Womens Initiatives', 
    'International Work Camp', 
    'Recreation', 
    'Adventure Travel', 
    'Scientific Research', 
    'Archaeology', 
    'Environmental Biology', 
    'Technology', 
    'Media Marketing and Graphic Design', ' ']
 end


 def validate_subjects_inclusions
  @return = true
   if !program_subjects.nil?
     @subjects = program_subjects.map(&:subject)
     @subjects.each do |f|
       if !(all_subjects.include?(f))
         errors.add(:program_subjects, "=> #{f} is not a valid tag")
         @return = false
       end
     end
   end
   return @return
 end
 
def textilize_textareas
  self.truncated_description100 = RedCloth.new( ActionController::Base.helpers.sanitize(truncate self.description, :length => 100), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
  self.description = RedCloth.new( ActionController::Base.helpers.sanitize( self.description ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
  self.program_cost_breakdown = RedCloth.new( ActionController::Base.helpers.sanitize( self.program_cost_breakdown ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html 
  self.cost_includes = RedCloth.new( ActionController::Base.helpers.sanitize( self.cost_includes ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
  self.cost_doesnt_include = RedCloth.new( ActionController::Base.helpers.sanitize( self.cost_doesnt_include ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
  self.accommodations = RedCloth.new( ActionController::Base.helpers.sanitize( self.accommodations ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html 
end

def set_location_name
  self.location_name = THECOUNTRIES[self.location]
end

def set_http
  if self.check_it_out[0..3] != "http"
    self.check_it_out = "http://"+self.check_it_out
  end
end

 
end
