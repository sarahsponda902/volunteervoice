class SessionsController < Devise::SessionsController 
  
  def create
    Devise.sign_out_all_scopes
    super
  end

end
