class User < ActiveRecord::Base
  
  include CarrierWave::MiniMagick
  
  apply_simple_captcha :message => "did not match the secret code", :distortion => "high"
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :photo, :username, :id, :age, :country, :dob, :notify, :square_photo, :crop_x, :crop_y, :crop_w, :crop_h, :captcha, :captcha_key, :approved, :volunteered_before, :admin_update, :admin_pass, :messages_show, :profile_show, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :confirmation_token, :crops, :square_image 
  has_many :ratings
  has_many :rated_reviews, :through => :ratings, :source => :reviews
  has_many :messages
  has_many :reviews
  has_many :favorites
  validates_uniqueness_of :username
  validates_uniqueness_of :email, :message => "is already in use"
  validates_presence_of :username, :email, :dob
  validates_length_of :username, :maximum => 30
  validates_format_of :email, :with => %r{.+@.+\..+}, :message => "is not valid"
  
  before_save :square_image_crop

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
 
  
  # Paperclip
mount_uploader :photo, ImageUploader
mount_uploader :square_image, ImageUploader
  
      
      #Simple Private Messaging     
      has_private_messages
#Sunspot Search
searchable do
  text :username, :boost => 5
  string :email, :country
end

def square_image_crop
   if !(self.crop_x.nil? || self.crop_y.nil? || self.crop_w.nil? || self.crop_h.nil?)
     image = MiniMagick::Image.open(self.image.url)
     crop_params = "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}"
     image.crop(crop_params)
     image.write "square_user_#{self.id}.jpg"
     self.square_image = File.open("square_user_#{self.id}.jpg")
     File.delete("square_user_#{self.id}.jpg")
   end
 end
  
end