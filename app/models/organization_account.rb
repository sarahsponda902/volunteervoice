# == Schema Information
#
# Table name: organization_accounts
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  position               :string(255)
#  type_of_company        :string(255)
#  nonprofit              :boolean
#  username               :string(255)
#  notify                 :boolean
#  country                :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  invitation_token       :string(60)
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  organization_id        :integer
#  organization_name      :string(255)
#  admin_pass             :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  email_confirmation     :string(255)
#

class OrganizationAccount < ActiveRecord::Base
  validates_uniqueness_of :email
  belongs_to :organization
  attr_accessor :login
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable, :invite_for => 0, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :email_confirmation, :password, :password_confirmation, :remember_me, :first_name, :last_name, :position, :type_of_company, :nonprofit, :username, :notify, :country, :organization_id, :organization_name, :admin_pass, :login
  before_update :validate_presence_of_all_fields

  
  def self.find_first_by_auth_conditions(warden_conditions)
        conditions = warden_conditions.dup
        if login = conditions.delete(:login)
          where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
        else
          where(conditions).first
        end
  end
  
  def validate_presence_of_all_fields
    @return = true
    unless invitation_accepted_at.nil?
    if first_name.nil?
      errors.add(:first_name, "must not be blank")
      @return = false
    end
    if last_name.nil?
      errors.add(:last_name, "must not be blank")
      @return = false
    end
    if position.nil?
      errors.add(:position, "must not be blank")
      @return = false
    end
    if type_of_company.nil?
      errors.add(:type_of_company, "must not be blank")
      @return = false
    end
    if username.nil?
      errors.add(:username, "must not be blank")
      @return = false
    end
    if country.nil?
      errors.add(:country, "must not be blank")
      @return = false
    end
    end
    return @return
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
  
  private
    
    def encrypted_pass
      return "4e5d0ed9183ebf2fed541412497e15a30e72f9cb"
    end
    
    
end
