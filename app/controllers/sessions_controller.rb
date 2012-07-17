class SessionsController < Devise::SessionsController 
  
  def create
    sign_out(current_user)
    super
  end

end
