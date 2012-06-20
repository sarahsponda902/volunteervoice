class ApplicationController < ActionController::Base
  protect_from_forgery
  
include SimpleCaptcha::ControllerHelpers

   def after_sign_in_path_for(resource_or_scope)
     if request.env['omniauth.origin']
       request.env['omniauth.origin']
     else
       '/'
     end
   end
end
