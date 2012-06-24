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
       if URI(request.referrer).path == '/reviews/new'
         '/'
       else
         request.referrer
       end
     end
   end
   
   def after_update_path_for(resource)
     "/pages/profile"
   end
   
   unless ActionController::Base.consider_all_requests_local
       rescue_from Exception, :with => :render_error
       rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
       rescue_from ActionController::RoutingError, :with => :render_not_found
       rescue_from ActionController::UnknownController, :with => :render_not_found
       rescue_from ActionController::UnknownAction, :with => :render_not_found
     end
     
     private

     def render_not_found(exception)
       log_error(exception)
       render :template => "/error/404.html.erb", :status => 404
     end

     def render_error(exception)
       log_error(exception)
       render :template => "/error/500.html.erb", :status => 500
     end
   
end
