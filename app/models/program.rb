class Program < ActiveRecord::Base
  
  include CarrierWave::MiniMagick
  
belongs_to :organization
has_many :reviews, :dependent => :destroy
has_many :program_subjects, :dependent => :destroy
has_many :program_lengths, :dependent => :destroy
has_many :program_sizes, :dependent => :destroy
attr_accessible :id, :photo, :name, :description, :weekly_cost, :location, :organization_id, :subject, :group_size, :headquarters, :length, :overall, :chart, :program_started, :start_dates, :program_structure, :partnered_local_organizations, :cost_includes, :cost_doesnt_include, :program_cost_breakdown, :accommodations, :check_it_out, :organization_name, :crop_x, :crop_y, :crop_w, :crop_h, :square_image, :program_subjects, :program_lengths, :program_sizes

before_save :square_image_crop
after_save :change_file_name
# Paperclip
    mount_uploader :chart, ImageUploader
    mount_uploader :photo, ImageUploader
    mount_uploader :square_image, ImageUploader
# Sunspot Search
searchable do
  text :name
    string :location
    string :subject
    string :organization_name
    string :weekly_cost
    string :group_size
    string :length
  
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

 def change_file_name 
   if self.photo 
     @name ||= Digest::MD5.hexdigest(self.photo.original_filename)
     self.photo.original_filename = "#{@name}.#{file.extension}"
     self.photo.save
   end
   
   if self.chart 
     @name ||= Digest::MD5.hexdigest(self.chart.original_filename)
     self.chart.original_filename = "#{@name}.#{file.extension}"
     self.chart.save
   end
 end
end
