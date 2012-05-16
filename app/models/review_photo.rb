class ReviewPhoto < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  attr_accessible :file, :review_id
  belongs_to :review
  mount_uploader :file, ReviewPhotoUploader
  
  
end
