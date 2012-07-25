class Program < ActiveRecord::Base
  require 'rubygems'
  require 'file_size_validator'
  require 'google_drive'
  include CarrierWave::MiniMagick
  
  
belongs_to :organization
has_many :reviews, :dependent => :destroy
has_many :program_subjects, :dependent => :destroy
has_many :program_cost_length_maps, :dependent => :destroy
has_many :program_sizes, :dependent => :destroy
attr_accessible :id, :photo, :name, :description, :weekly_cost, :location, :organization_id, :subject, :group_size, :headquarters, :length, :overall, :chart, :program_started, :start_dates, :program_structure, :partnered_local_organizations, :cost_includes, :cost_doesnt_include, :program_cost_breakdown, :accommodations, :check_it_out, :organization_name, :crop_x, :crop_y, :crop_w, :crop_h, :square_image, :program_subjects, :program_sizes, :specific_location, :location_name, :program_cost_length_maps, :published_docs, :food_situation, :lengths_of_program, :program_requirements
validates_presence_of :name, :description, :weekly_cost, :location, :organization_id, :program_started, :start_dates, :partnered_local_organizations, :cost_includes, :cost_doesnt_include, :program_cost_breakdown, :accommodations, :program_subjects, :program_sizes, :specific_location, :program_cost_length_maps, :food_situation, :lengths_of_program, :program_requirements
before_save :copy_organization_images_and_program_model
before_save :square_image_crop
before_save :validate_subjects_inclusion
after_save :update_cost_chart
after_save :update_org_chart
before_destroy :delete_cost_chart
# Paperclip
    mount_uploader :photo, ImageUploader
    mount_uploader :square_image, ImageUploader
# Sunspot Search

def copy_organization_images_and_program_model
  self.photo = Organization.find(organization_id).image.file
  self.square_image = Organization.find(organization_id).square_image.file
  self.program_structure = Organization.find(organization_id).volunteer_program_model
end

def delete_cost_chart
  session = GoogleDrive.login("sarah@volunteervoice.org", "duq7395005693")
  template = session.spreadsheet_by_title("Testing")
  ss = session.spreadsheet_by_title("#{name}")
  if !ss.nil?
    ss.delete(permanent = true)
  end
end

def update_cost_chart
  session = GoogleDrive.login("sarah@volunteervoice.org", "duq7395005693")
  template = session.spreadsheet_by_title("Testing")
  ss = session.spreadsheet_by_title("#{name}")
  if !ss.nil?
    ss.delete(permanent = true)
  end
  ss = template.duplicate( title = "#{name}")
  ws = ss.worksheets[0]
  count = 2
  @ps = program_cost_length_maps.sort_by(&:length)
  @ps.each do |f|
    ws["A#{count}"] = (f.length / 604800).round
    ws["B#{count}"] = f.cost
    ws["C#{count}"] = (f.cost / ((f.length / 604800).round)).round
    count = count + 1
  end
  ws.save()
  self.chart = ss.human_url.split("key=")[1]
  self.save!
end

def update_org_chart
  session = GoogleDrive.login("sarah@volunteervoice.org", "duq7395005693")
  template = session.spreadsheet_by_title("Testing")
  ss = session.spreadsheet_by_title("Organization: #{Organization.find(organization_id).name}")
  if !ss.nil?
    ss.delete(permanent = true)
  end
  ss = template.duplicate( title = "Organization: #{Organization.find(organization_id).name}")
  ws = ss.worksheets[0]
  count = 2  
  @sorted = ProgramCostLengthMap.where(:organization_id => organization_id).sort_by(&:length)
  @lengths = []
  @sorted.each do |f|
    @lengths << f.length unless @lengths.include?(f.length)
  end
  @grouped = []
  @lengths.each do |f|
    @grouped << ProgramCostLengthMap.where(:organization_id => organization_id, :length => f)
  end
  @entries = []
  @grouped.each do |a|
    @sorted_group = a.sort_by(&:cost)
    @entries << [a.first.length, a.first.cost, a.last.cost]
  end
  @entries.each do |f|
    ws["A#{count}"] = (f[0] / 604800).round
    ws["B#{count}"] = f[1]
    ws["C#{count}"] = f[2]
  end
  ws.save()
  @org = Organization.find(organization_id)
  @org.price_ranges = ss.human_url.split("key=")[1]
  @org.save!
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


 def validate_subjects_inclusions
  @return = true
   @all_subjects = ['Agriculture', 
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
   'Sports &amp; Recreation', 
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
   'Media Marketing and Graphic Design']
   if !program_subjects.nil?
     @subjects = program_subjects.map(&:subject)
     @subjects.each do |f|
       if !(@all_subjects.include?(f))
         errors.add_to_base("#{f} is not a valid subject tag")
         @return = false
       end
     end
   end
   return @return
 end
 
end
