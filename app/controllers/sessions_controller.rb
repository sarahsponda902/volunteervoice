class SessionsController < Devise::SessionsController 
  def new
    session[:return_to] = request.referrer
    super
  end
  
  def create
    session[:return_to] = request.referrer
    super
  end
  
  def destroy
    session[:return_to] = request.referrer
    super
  end
end