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

after_save :change_file_names



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
    @name ||= Digest::MD5.hexdigest(self.photo.filename)
    self.photo.filename = "#{@name}.#{file.extension}"
    self.photo.save
  end
  if self.photo2 
    @name ||= Digest::MD5.hexdigest(self.photo2.filename)
    self.photo2.filename = "#{@name}.#{file.extension}"
    self.photo2.save
  end
  if self.photo3 
    @name ||= Digest::MD5.hexdigest(self.photo3.filename)
    self.photo3.filename = "#{@name}.#{file.extension}"
    self.photo3.save
  end
  if self.photo4 
    @name ||= Digest::MD5.hexdigest(self.photo4.filename)
    self.photo4.filename = "#{@name}.#{file.extension}"
    self.photo4.save
  end
  if self.photo5 
    @name ||= Digest::MD5.hexdigest(self.photo5.filename)
    self.photo5.filename = "#{@name}.#{file.extension}"
    self.photo5.save
  end
  if self.photo6 
    @name ||= Digest::MD5.hexdigest(self.photo6.filename)
    self.photo6.filename = "#{@name}.#{file.extension}"
    self.photo6.save
  end
  if self.photo7 
    @name ||= Digest::MD5.hexdigest(self.photo7.filename)
    self.photo7.filename = "#{@name}.#{file.extension}"
    self.photo7.save
  end
  if self.photo8 
    @name ||= Digest::MD5.hexdigest(self.photo8.filename)
    self.photo8.filename = "#{@name}.#{file.extension}"
    self.photo8.save
  end
  if self.photo9 
    @name ||= Digest::MD5.hexdigest(self.photo9.filename)
    self.photo9.filename = "#{@name}.#{file.extension}"
    self.photo9.save
  end
  if self.photo10 
    @name ||= Digest::MD5.hexdigest(self.photo10.filename)
    self.photo10.filename = "#{@name}.#{file.extension}"
    self.photo10.save
  end
end

end
