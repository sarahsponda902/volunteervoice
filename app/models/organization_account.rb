class OrganizationAccount < ActiveRecord::Base
  validates_uniqueness_of :email
  validates_exclusion_of :organization_id, :in => OrganizationAccount.all.map(&:organization_id)
  belongs_to :organization
  attr_accessor :login
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable, :invite_for => 0, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :position, :type_of_company, :nonprofit, :username, :notify, :country, :organization_id, :organization_name, :admin_pass, :login
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
    if first_name.nil?
      errors.add(:first_name, "must not be blank")
    end
    if last_name.nil?
      errors.add(:last_name, "must not be blank")
    end
    if position.nil?
      errors.add(:position, "must not be blank")
    end
    if type_of_company.nil?
      errors.add(:type_of_company, "must not be blank")
    end
    if username.nil?
      errors.add(:username, "must not be blank")
    end
    if country.nil?
      errors.add(:country, "must not be blank")
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
  
  private
    
    def encrypted_pass
      return "4e5d0ed9183ebf2fed541412497e15a30e72f9cb"
    end
    
    
end
