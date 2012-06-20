class SessionsController < Devise::SessionsController 
  
  def after_sign_in_path_for(resource)
    :back
  end
  
end
