# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  email                     :string(255)      default(""), not null
#  encrypted_password        :string(255)      default(""), not null
#  reset_password_token      :string(255)
#  reset_password_sent_at    :datetime
#  remember_created_at       :datetime
#  sign_in_count             :integer          default(0)
#  current_sign_in_at        :datetime
#  last_sign_in_at           :datetime
#  current_sign_in_ip        :string(255)
#  last_sign_in_ip           :string(255)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  username                  :string(255)
#  age                       :integer
#  country                   :string(255)
#  admin                     :boolean          default(FALSE)
#  validate_user_email       :string(255)
#  validate_user_name        :string(255)
#  dob                       :datetime
#  notify                    :boolean          default(TRUE)
#  verify                    :boolean
#  crop_x                    :integer
#  crop_y                    :integer
#  crop_w                    :integer
#  crop_h                    :integer
#  square_photo_content_type :string(255)
#  approved                  :boolean          default(FALSE), not null
#  volunteered_before        :boolean
#  admin_pass                :string(255)
#  admin_update              :boolean
#  profile_show              :boolean          default(TRUE)
#  messages_show             :boolean
#  confirmation_token        :string(255)
#  confirmed_at              :datetime
#  confirmation_sent_at      :datetime
#  unconfirmed_email         :string(255)
#  photo                     :string(255)
#  failed_attempts           :integer          default(0)
#  unlock_token              :string(255)
#  locked_at                 :datetime
#  square_image              :string(255)
#  cropping                  :boolean
#  crops                     :boolean
#  unread_messages           :integer
#  return_link               :string(255)
#  admin_read                :boolean          default(FALSE)
#

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
  
  
  validates_uniqueness_of :email, :case_sensitive => false, :allow_blank => true, :if => :email_changed?
  validates_format_of :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?
  validates_presence_of :password, :on=>:create
  validates_confirmation_of :password, :on=>:create
  validates_length_of :password, :within => Devise.password_length, :allow_blank => true
  validates_uniqueness_of :username
  validates_presence_of :username
  validates_length_of :username, :maximum => 30
  validates_presence_of :email
  validates_confirmation_of :email, :on => :create, :message => "did not match confirmation"
  
  before_save :square_image_crop 
  after_create :send_message
  before_create :set_unread_message_count


  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :lockable, :validatable

  # Setup accessible (or protected) attributes for your model
 
  
  # Carrierwave
mount_uploader :photo, ImageUploader
mount_uploader :square_image, ImageUploader
  
      
      #Simple Private Messaging     
      has_private_messages
      
      
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
       resize_scale = (700/image[:width].to_f) * 100
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
 
 def set_unread_message_count
   self.unread_messages = 1
 end

 def send_message
   if self.id != 1
     admin_sender = User.find(1)
     user_receiver = self
     message = Message.new
     message.subject = "It's Official! You're in."
     message.body = "As a member of the VVI community, you're now able to contact other volunteers directly, share your own experiences online, and stay active in our mission to make the world of international volunteering more transparent, more organized, and more excellent. 
     <br /><br />We can't thank you enough for joining the cause!  And we're here if you need anything.
     <br /><br />--VolunteerVoice Team"
     message.recipient = user_receiver
     message.sender = admin_sender
     message.save
   end
 end
end
