class Program < ActiveRecord::Base
  
  include CarrierWave::MiniMagick
  
belongs_to :organization
has_many :reviews
attr_accessible :id, :photo, :name, :description, :weekly_cost, :location, :organization_id, :subject, :group_size, :headquarters, :length, :overall, :chart, :program_started, :start_dates, :program_structure, :partnered_local_organizations, :cost_includes, :cost_doesnt_include, :program_cost_breakdown, :accommodations, :check_it_out, :organization_name, :crop_x, :crop_y, :crop_w, :crop_h, :square_image
before_create :image_save
before_save :square_image_crop

# Paperclip
    mount_uploader :photo, ImageUploader
    mount_uploader :square_image, ImageUploader
# Sunspot Search
searchable do
  text :name, :boost => 10
  text :description 
  string :location
  string :subject
  string :headquarters
  integer :weekly_cost
  integer :group_size
  integer :length
  
end

def roundup(overall)
    (overall*2).round / 2.0
end

def square_image_crop
  if !(self.crop_x.nil? || self.crop_y.nil? || self.crop_w.nil? || self.crop_h.nil?)
    image = MiniMagick::Image.open(self.photo.url)
    crop_params = "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}"
    image.crop(crop_params)
    self.square_image = image
  end
end

end
