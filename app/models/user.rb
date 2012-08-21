class User < ActiveRecord::Base
    require 'file_size_validator'
  include CarrierWave::MiniMagick

  apply_simple_captcha :message => "did not match the secret code", :distortion => "high"

  attr_accessor :login
  attr_accessible :email, :email_confirmation, :password, :password_confirmation, :remember_me, :photo, :username, :id, :age, :country, :dob, :notify, :square_photo, :crop_x, :crop_y, :crop_w, :crop_h, :captcha, :captcha_key, :approved, :volunteered_before, :admin_update, :admin_pass, :messages_show, :profile_show, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :confirmation_token, :crops, :square_image, :login, :return_link 
  has_many :messages
  has_many :reviews, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy
  has_many :flags
  has_many :new_reviews, :dependent => :destroy
  validates_uniqueness_of :username
  validates_uniqueness_of :email, :message => "is already in use"
  validates_presence_of :username
  validates_presence_of :dob, :message => "Date of Birth can't be blank"
  validates_length_of :username, :maximum => 30
  before_save :square_image_crop 
  before_create :validate_email
  validates :photo, :file_size => {:maximum => 1.megabytes.to_i}


  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
 
  
  # Carrierwave
mount_uploader :photo, ImageUploader
mount_uploader :square_image, ImageUploader
  
      
      #Simple Private Messaging     
      has_private_messages

      def validate_email
        if !(email == email_confirmation)
          errors.add(:email, "must match")
          return false
        end
      end
      
      
def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
end


def square_image_crop
  if (self.crops)
   if !(self.crop_x.nil? || self.crop_y.nil? || self.crop_w.nil? || self.crop_h.nil?)
     image = MiniMagick::Image.open(self.photo.url)
     if image[:width] > 700
       resize_scale = 700/image[:width]
       image.sample(resize_scale.to_s + "%")
     end
     image.crop("#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}")
     image.set("page", "#{self.crop_w}x#{self.crop_h}+#{self.crop_x}+#{self.crop_y}") 
     self.square_image = image
   end
  end
 end
 
 def update_with_password(params, *options)
   current_password = params.delete(:current_password)

   if params[:password].blank?
     params.delete(:password)
     params.delete(:password_confirmation) if params[:password_confirmation].blank?
   end

   result = if params[:password].blank? || valid_password?(current_password) 
     update_attributes(params, *options)
   else
     self.assign_attributes(params, *options)
     self.valid?
     self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
     false
   end

   clean_up_passwords
   result
 end

 
end