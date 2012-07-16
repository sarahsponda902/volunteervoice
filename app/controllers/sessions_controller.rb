class SessionsController < Devise::SessionsController 
  
  def create
    if user_signed_in?
      sign_out(current_user)
    end
    if organization_account_signed_in?
      sign_out(current_organization_account)
    end
    super
  end

end
