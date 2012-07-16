class SessionsController < Devise::SessionsController 
  before_filter :store_location
  
  private

    def store_location
      session[:user_return_to] = URI(request.referrer).path
    end
end
