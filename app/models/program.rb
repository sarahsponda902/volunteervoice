class Program < ActiveRecord::Base
belongs_to :organization
has_many :reviews
attr_accessible :id, :photo, :name, :description, :weekly_cost, :location, :organization_id, :subject, :group_size, :headquarters, :length, :overall, :chart, :program_started, :start_dates, :program_structure, :partnered_local_organizations, :cost_includes, :cost_doesnt_include, :program_cost_breakdown, :accommodations, :check_it_out, :organization_name

validates_file_extension_of :photo, :allowed => ["jpg", "png", "jpeg", "gif"], :message => "must have one of the following extensions: jpg, jpeg, png, gif"
validates_file_size_of :photo, :less_than => 1 * 1024 * 1024, :message => "must be no more than 1024x1024"
validates_file_extension_of :chart, :allowed => ["jpg", "png", "jpeg", "gif"], :message => "must have one of the following extensions: jpg, jpeg, png, gif"
validates_file_size_of :chart, :less_than => 1 * 1024 * 1024, :message => "must be no more than 1024x1024"


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

end
