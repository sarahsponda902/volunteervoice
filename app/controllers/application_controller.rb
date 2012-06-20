class ApplicationController < ActionController::Base
  protect_from_forgery
  
include SimpleCaptcha::ControllerHelpers

   def after_sign_in_path_for(resource)
     if !(resource.return_link.nil?)
       @link = resource.return_link
       resource.return_link = nil
       resource.save
       @link
     else
       if request.referrer
         if ((URI(request.referrer).path == '/users/sign_in') || (URI(request.referrer).path == '/registrations/mustBe'))
           '/'
         else
           request.referrer
         end
       else
         '/'
       end
    end
   end
   
   def after_sign_out_path_for(resource)
     if URI(request.referrer).path == '/registrations/mustBe'
       '/'
     else
       request.referrer
     end
   end
   
   def after_update_path_for(resource)
     "/pages/profile"
   end
end
