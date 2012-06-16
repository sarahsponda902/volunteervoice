class Review < ActiveRecord::Base

@orgs = []
Organization.all.each do |f|
  @orgs << f.name
end
  
validates :terms, :acceptance => {:accept => true}
validates :program_id, :presence => true
validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 
characters."
validates_length_of :body, :maximum => 10000, :message => "You have entered more than 10,000 characters"
validates_inclusion_of :organization_name, :in => @orgs
validate :validate_image_size
belongs_to :program
belongs_to :user
has_many :flags, :dependent => :destroy




attr_accessible :user_id, :program_id, :body, :rating, :photo, :show, :organization_id, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, :photo2, :photo3, :photo4, :photo5, :photo6, :photo7, :photo8, :photo9, :photo10, :organization_name

# Paperclip
mount_uploader :photo, ImageUploader
mount_uploader :photo2, ImageUploader
mount_uploader :photo3, ImageUploader
mount_uploader :photo4, ImageUploader
mount_uploader :photo5, ImageUploader
mount_uploader :photo6, ImageUploader
mount_uploader :photo7, ImageUploader
mount_uploader :photo8, ImageUploader
mount_uploader :photo9, ImageUploader
mount_uploader :photo10, ImageUploader


def validate_image_size
  image = MiniMagick::Image.open(self.photo.path) unless !self.photo.path
  image2 = MiniMagick::Image.open(self.photo2.path) unless !self.photo2.path
  image3 = MiniMagick::Image.open(self.photo3.path) unless !self.photo3.path
  image4 = MiniMagick::Image.open(self.photo4.path) unless !self.photo4.path
  image5 = MiniMagick::Image.open(self.photo5.path) unless !self.photo5.path
  image6 = MiniMagick::Image.open(self.photo6.path) unless !self.photo6.path
  image7 = MiniMagick::Image.open(self.photo7.path) unless !self.photo7.path
  image8 = MiniMagick::Image.open(self.photo8.path) unless !self.photo8.path
  image9 = MiniMagick::Image.open(self.photo9.path) unless !self.photo9.path
  image10 = MiniMagick::Image.open(self.photo10.path) unless !self.photo10.path
  if image
    unless (image[:width] < 700 && image[:height])
      errors.add :image, "must be smaller than 700x700 px" 
    end
  end
  if image
    unless (image[:width] < 700 && image[:height])
      errors.add :image, "must be smaller than 700x700 px" 
    end
  end
  if image2
    unless (image2[:width] < 700 && image2[:height])
      errors.add :image2, "must be smaller than 700x700 px" 
    end
  end
  if image3
    unless (image3[:width] < 700 && image3[:height])
      errors.add :image3, "must be smaller than 700x700 px" 
    end
  end
  if image4
    unless (image4[:width] < 700 && image4[:height])
      errors.add :image4, "must be smaller than 700x700 px" 
    end
  end
  if image5
    unless (image5[:width] < 700 && image5[:height])
      errors.add :image5, "must be smaller than 700x700 px" 
    end
  end
  if image6
    unless (image6[:width] < 700 && image6[:height])
      errors.add :image6, "must be smaller than 700x700 px" 
    end
  end
  if image7
    unless (image7[:width] < 700 && image7[:height])
      errors.add :image7, "must be smaller than 700x700 px" 
    end
  end
  if image8
    unless (image8[:width] < 700 && image8[:height])
      errors.add :image8, "must be smaller than 700x700 px" 
    end
  end
  if image9
    unless (image9[:width] < 700 && image9[:height])
      errors.add :image9, "must be smaller than 700x700 px" 
    end
  end
  if image10
    unless (image10[:width] < 700 && image10[:height])
      errors.add :image10, "must be smaller than 700x700 px" 
    end
  end
  
  
end

end
