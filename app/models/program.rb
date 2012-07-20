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
attr_accessible :id, :photo, :name, :description, :weekly_cost, :location, :organization_id, :subject, :group_size, :headquarters, :length, :overall, :chart, :program_started, :start_dates, :program_structure, :partnered_local_organizations, :cost_includes, :cost_doesnt_include, :program_cost_breakdown, :accommodations, :check_it_out, :organization_name, :crop_x, :crop_y, :crop_w, :crop_h, :square_image, :program_subjects, :program_sizes, :specific_location, :location_name, :program_cost_length_maps, :published_docs
validates :photo, :file_size => {:maximum => 0.5.megabytes.to_i}
before_save :square_image_crop
before_save :update_cost_chart
validate :published_docs_true

# Paperclip
    mount_uploader :photo, ImageUploader
    mount_uploader :square_image, ImageUploader
# Sunspot Search

def update_cost_chart
  session = GoogleDrive.login("sarah@volunteervoice.org", "duq7395005693")
  ss = session.spreadsheet_by_title("#{name}")
  if ws.nil?
    ss = session.create_spreadsheet( title = "#{name}")
  end
  ws = ss.worksheets[0]
  ws.rows = [["foo", "face", "you"], ["same", "love", "winnie"]]
  ws.save()
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

 def published_docs_true
   if !(published_docs)
     errors.add(:published_docs, "must be published")
   end
 end
end
