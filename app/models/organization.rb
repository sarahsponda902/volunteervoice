class Organization < ActiveRecord::Base
has_many :comments
has_many :programs
has_many :review_os
attr_accessible :image, :name, :description, :show, :overall, :num_reviews, :program_id, :page_views, :mission, :phone, :email, :operating_since, :num_vols_date, :num_vols_yr, :application_process, :business_model, :program_model, :good_to_know, :reviews_count, :trining_resources, :program_costs, :program_costs_breakdown, :program_costs_includes, :url, :run_by, :id_number, :volunteer_program_model, :price_ranges, :training_resources, :crop_x, :crop_y, :crop_w, :crop_h, :square_image
validates_file_extension_of :image, :allowed => ["jpg", "png", "jpeg", "gif"], :message => "must have one of the following extensions: jpg, jpeg, png, gif"
validates_file_size_of :image, :less_than => 1 * 1024 * 1024, :message => "must be no more than 1024x1024"
validates_presence_of :image

scope :random, :order=>'RAND()', :limit=>1
validates_uniqueness_of :name
before_save :square_image_crop

before_create :set_page_views_to_zero
  def set_page_views_to_zero
    self.page_views = 0
  end

# Paperclip
has_attached_file :image
    
# Sunspot Search
searchable do
  text :name, :boost => 10
  text :description
end


def roundup(overall)
    (overall*2).round / 2.0
end

def square_image_crop
  if !(self.crop_x.nil? || self.crop_y.nil? || self.crop_w.nil? || self.crop_h.nil?)
    image = MiniMagick::Image.open(self.image.url)
    crop_params = "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}"
    image.crop(crop_params)
    image.write "tempfile_#{self.id}_organization.jpg"
    AWS::S3::S3Object.store(self.id.to_s+"_square.jpg", open("tempfile_#{self.id}_organization.jpg"), "volunteervoice_organizationsquareimages", :access=>:public_read)
    FileUtils.rm "tempfile_#{self.id}_organization.jpg"
    self.square_image = "https://s3.amazonaws.com/volunteervoice_organizationsquareimages/#{self.id.to_s}_square.jpg"
  end
end


end
