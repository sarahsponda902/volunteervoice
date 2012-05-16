class ReviewPhoto < ActiveRecord::Base
  
  attr_accessible :file, :review_id, :file_cache
  belongs_to :review
  mount_uploader :file, ReviewPhotoUploader
  
  
end
