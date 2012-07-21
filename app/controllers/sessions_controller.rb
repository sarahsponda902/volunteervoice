class OrganizationAccount::SessionsController < Devise::SessionsController 
  
  def create
    sign_out(current_user) unless !user_signed_in?
    super
  end

end
