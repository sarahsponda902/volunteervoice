class Organization < ActiveRecord::Base
  
  include CarrierWave::MiniMagick
  
has_many :comments
has_many :programs
has_many :review_os
attr_accessible :image, :name, :description, :show, :overall, :num_reviews, :program_id, :page_views, :misson, :phone, :email, :operating_since, :num_vols_date, :num_vols_yr, :application_process, :business_model, :program_model_string, :good_to_know, :reviews_count, :trining_resources, :price_ranges, :program_costs_breakdown, :program_costs_includes, :url, :run_by, :id_number, :volunteer_program_model, :price_ranges, :training_resources, :crop_x, :crop_y, :crop_w, :crop_h, :square_image, :program_costs_doesnt_include, :program_costs_breakdown
validates_presence_of :image

scope :random, :order=>'RAND()', :limit=>1
validates_uniqueness_of :name

before_save :square_image_crop

before_create :set_page_views_to_zero
  def set_page_views_to_zero
    self.page_views = 0
  end

# Paperclip
    mount_uploader :image, ImageUploader
    mount_uploader :square_image, ImageUploader
    mount_uploader :price_breakdown, ImageUploader
    mount_uploader :price_ranges, ImageUploader
# Sunspot Search
searchable do
  text :name, :boost =>9
  text :business_model , :boost =>5
  text :program_costs_includes , :boost =>5
end


def roundup(overall)
    (overall*2).round / 2.0
end

def square_image_crop
   if !(self.crop_x.nil? || self.crop_y.nil? || self.crop_w.nil? || self.crop_h.nil?)
     image = MiniMagick::Image.open(self.image.url)
     image.crop("#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}")
     image.set("page", "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}") 
     self.square_image = image
   end
 end


end
