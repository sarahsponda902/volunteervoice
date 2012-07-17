class OrganizationAccount < ActiveRecord::Base
  validates_exclusion_of :organization_id, :in => OrganizationAccount.all.map(&:organization_id)
  validate :validates_admin_pass
  belongs_to :organization
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :invitable, :invite_for => 0

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :position, :type_of_company, :nonprofit, :username, :notify, :country, :organization_id, :organization_name, :admin_pass
  
  def validates_admin_pass
    if admin_pass != encrypted_pass
      errors[:base] << "You must be an administrator to create an account for an organization"
    end
  end
  
  private
    
    def encrypted_pass
      return "4e5d0ed9183ebf2fed541412497e15a30e72f9cb"
    end
end
