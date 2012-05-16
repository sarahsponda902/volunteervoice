class ReviewPhoto < ActiveRecord::Base
  
  attr_accessible :file, :review_id
  belongs_to :review
  mount_uploader :file, ReviewPhotoUploader
  
  
end
