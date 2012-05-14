class Organization < ActiveRecord::Base
has_many :comments
has_many :programs
has_many :review_os
attr_accessible :image, :name, :description, :show, :overall, :num_reviews, :program_id, :page_views, :mission, :phone, :email, :operating_since, :num_vols_date, :num_vols_yr, :application_process, :business_model, :program_model, :good_to_know, :reviews_count, :trining_resources, :program_costs, :program_costs_breakdown, :program_costs_includes, :url, :run_by, :id_number, :volunteer_program_model, :price_ranges, :training_resources
validates_file_extension_of :image, :allowed => ["jpg", "png", "jpeg", "gif"], :message => "must have one of the following extensions: jpg, jpeg, png, gif"
validates_file_size_of :image, :less_than => 1 * 1024 * 1024, :message => "must be no more than 1024x1024"
validates_presence_of :image

scope :random, :order=>'RAND()', :limit=>1
validates_uniqueness_of :name

before_create :set_page_views_to_zero
  def set_page_views_to_zero
    self.page_views = 0
  end

# Paperclip
has_file :image, PhotoUploader
    
# Sunspot Search
searchable do
  text :name, :boost => 10
  text :description
end


def roundup(overall)
    (overall*2).round / 2.0
end


end
