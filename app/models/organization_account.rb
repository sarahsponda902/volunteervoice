class OrganizationAccount < ActiveRecord::Base
  validates_exclusion_of :organization_id, :in => OrganizationAccount.all.map(&:organization_id)
  validates_presence_of :invitation_token
  validate :admin_signed_in
  
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable, :invite_for => 0

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :position, :type_of_company, :nonprofit, :username, :notify, :country, :organization_id, :organization_name

  def admin_signed_in
    if !(user_signed_in && current_user.admin?)
      errors.add_to_base("You must be an administrator to create an organization's account")
    end
  end

end
