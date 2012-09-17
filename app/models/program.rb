class Program < ActiveRecord::Base
  require 'rubygems'
  require 'file_size_validator'
  include CarrierWave::MiniMagick
  
  
belongs_to :organization
has_many :reviews, :dependent => :destroy
has_many :program_subjects, :dependent => :destroy
has_many :program_cost_length_maps, :dependent => :destroy
has_many :program_sizes, :dependent => :destroy
attr_accessible :id, :photo, :name, :description, :weekly_cost, :location, :organization_id, :subject, :group_size, :headquarters, :length, :overall, :chart, :program_started, :start_dates, :program_structure, :partnered_local_organizations, :cost_includes, :cost_doesnt_include, :program_cost_breakdown, :accommodations, :check_it_out, :organization_name, :crop_x, :crop_y, :crop_w, :crop_h, :square_image, :program_subjects, :program_sizes, :specific_location, :location_name, :program_cost_length_maps, :published_docs, :food_situation, :lengths_of_program, :program_requirements
validates_presence_of :name, :description, :location, :organization_id, :program_started, :start_dates, :partnered_local_organizations, :cost_includes, :cost_doesnt_include, :program_cost_breakdown, :accommodations, :program_subjects, :program_sizes, :specific_location, :program_cost_length_maps, :food_situation, :lengths_of_program, :program_requirements
before_save :copy_organization_images_and_program_model
before_save :square_image_crop
before_save :validate_subjects_inclusions

# Paperclip
    mount_uploader :photo, ImageUploader
    mount_uploader :square_image, ImageUploader
# Sunspot Search

def copy_organization_images_and_program_model
  self.photo = Organization.find(organization_id).image.file
  self.square_image = Organization.find(organization_id).square_image.file
  self.program_structure = Organization.find(organization_id).program_model_string
end




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


def roundup(overall)
    (overall*2).round / 2.0
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
 
end
