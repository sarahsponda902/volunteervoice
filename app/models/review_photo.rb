class ReviewPhoto < ActiveRecord::Base
  
  attr_accessible :file, :review_id, :file_cache
  belongs_to :review, :polymorphic => true
  mount_uploader :file, ReviewPhotoUploader
  
  def file=(val)
    if !val.is_a?(String) && valid?
      file_will_change!
      super
    end
  end
  
  
end
