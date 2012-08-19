class ApplicationController < ActionController::Base
  protect_from_forgery
  
include SimpleCaptcha::ControllerHelpers

   def after_sign_in_path_for(resource)
       if request.referrer
         if ((URI(request.referrer).path == '/users/sign_in') || (URI(request.referrer).path == '/registrations/mustBe')) || (URI(request.referrer).path == '/sign_up') || (URI(request.referrer).path == '/sign_in') || (URI(request.referrer).path == '/users/sign_up')
           '/'
         else
           request.referrer
         end
       else
         '/'
       end
   end
   
   def after_sign_out_path_for(resource)
     if URI(request.referrer).path == '/registrations/mustBe'
       '/'
     else
       if URI(request.referrer).path == '/reviews/new'
         '/'
       else
         if URI(request.referrer).path == '/users/profile'
           '/'
         else
           request.referrer
         end
       end
    end
   end
   
end
