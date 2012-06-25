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
   
   unless Rails.application.config.consider_all_requests_local
       rescue_from Exception, with: :render_500
       rescue_from ActionController::RoutingError, with: :render_404
       rescue_from ActionController::UnknownController, with: :render_404
       rescue_from ActionController::UnknownAction, with: :render_404
       rescue_from ActiveRecord::RecordNotFound, with: :render_404
       rescue_from ActionController::UnknownController,  with: :render_404
       rescue_from ActionController::UnknownAction, with: :render_404
     end

     private
     def render_404(exception)
       @not_found_path = exception.message
       if !(@not_found_path.include?("searches")) 
         respond_to do |format|
           format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
           format.all { render nothing: true, status: 404 }
         end
      else
         respond_to do |format|
           format.html { render template: 'errors/error_searches', layout: 'layouts/application', status: 404 }
           format.all { render nothing: true, status: 404 }
         end
      end
        
     end

     def render_500(exception)
       @error = exception
       respond_to do |format|
         format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
         format.all { render nothing: true, status: 500}
       end
     end
   
end
