class ReviewPhoto < ActiveRecord::Base
  attr_accessible :image, :review_id, :file
  belongs_to :review
  mount_uploader :image, ReviewPhotoUploader
  
  
end
