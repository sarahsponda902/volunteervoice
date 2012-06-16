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
belongs_to :program
belongs_to :user

before_save :change_file_names



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

def change_file_names
  if self.photo 
    @name ||= Digest::MD5.hexdigest(File.basename(self.photo.url))
    self.photo = "#{@name}.#{file.extension}"
  end
  if self.photo2 
    @name ||= Digest::MD5.hexdigest(File.basename(self.photo2.url))
    self.photo2 = "#{@name}.#{file.extension}"
  end
  if self.photo3 
    @name ||= Digest::MD5.hexdigest(File.basename(self.photo3.url))
    self.photo3 = "#{@name}.#{file.extension}"
  end
  if self.photo4 
    @name ||= Digest::MD5.hexdigest(File.basename(self.photo4.url))
    self.photo4 = "#{@name}.#{file.extension}"
  end
  if self.photo5 
    @name ||= Digest::MD5.hexdigest(File.basename(self.photo5.url))
    self.photo5 = "#{@name}.#{file.extension}"
  end
  if self.photo6 
    @name ||= Digest::MD5.hexdigest(File.basename(self.photo6.url))
    self.photo6 = "#{@name}.#{file.extension}"
  end
  if self.photo7 
    @name ||= Digest::MD5.hexdigest(File.basename(self.photo7.url))
    self.photo7 = "#{@name}.#{file.extension}"
  end
  if self.photo8 
    @name ||= Digest::MD5.hexdigest(File.basename(self.photo8.url))
    self.photo8 = "#{@name}.#{file.extension}"
  end
  if self.photo9 
    @name ||= Digest::MD5.hexdigest(File.basename(self.photo9.url))
    self.photo9 = "#{@name}.#{file.extension}"
  end
  if self.photo10 
    @name ||= Digest::MD5.hexdigest(File.basename(self.photo10.url))
    self.photo10 = "#{@name}.#{file.extension}"
  end
end

end
