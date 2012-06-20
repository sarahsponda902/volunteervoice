class ApplicationController < ActionController::Base
  protect_from_forgery
  
include SimpleCaptcha::ControllerHelpers

   def after_sign_in_path_for(resource_or_scope)
     if URI(request.referrer).path != '/users/sign_in'
       request.referrer
     else
       '/'
     end
   end
   
   def after_sign_out_path_for(resource_or_scope)
     request.referrer
   end
end
