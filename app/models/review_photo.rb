class ReviewPhoto < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  mount_uploader :file, ReviewPhotoUploader
  
  def to_jq_upload
      {
        "name" => read_attribute(:file),
        "size" => file.size,
        "url" => file.url,
        "thumbnail_url" => file.thumb.url,
        "delete_url" => review_photo_path(:id => id),
        "delete_type" => "DELETE" 
      }
    end
  
  
end
