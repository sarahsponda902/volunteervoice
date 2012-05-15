class Program < ActiveRecord::Base
belongs_to :organization
has_many :reviews
attr_accessible :id, :photo, :name, :description, :weekly_cost, :location, :organization_id, :subject, :group_size, :headquarters, :length, :overall, :chart, :program_started, :start_dates, :program_structure, :partnered_local_organizations, :cost_includes, :cost_doesnt_include, :program_cost_breakdown, :accommodations, :check_it_out, :organization_name

validates_file_extension_of :photo, :allowed => ["jpg", "png", "jpeg", "gif"], :message => "must have one of the following extensions: jpg, jpeg, png, gif"
validates_file_size_of :photo, :less_than => 1 * 1024 * 1024, :message => "must be no more than 1024x1024"
validates_file_extension_of :chart, :allowed => ["jpg", "png", "jpeg", "gif"], :message => "must have one of the following extensions: jpg, jpeg, png, gif"
validates_file_size_of :chart, :less_than => 1 * 1024 * 1024, :message => "must be no more than 1024x1024"

before_save :square_image_crop

# Paperclip
  has_file :photo, PhotoUploader
		
  has_file :chart, PhotoUploader
    
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
    image = MiniMagick::Image.open(self.image.url)
    crop_params = "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}"
    image.crop(crop_params)
    image.write "tempfile_#{self.id}_program.jpg"
    AWS::S3::S3Object.store(self.id.to_s+"_square.jpg", open("tempfile_#{self.id}_program.jpg"), "volunteervoice_programsquareimages", :access=>:public_read)
    FileUtils.rm "tempfile_#{self.id}_program.jpg"
    self.square_image = "https://s3.amazonaws.com/volunteervoice_programsquareimages/#{self.id.to_s}_square.jpg"
  end
end

end
