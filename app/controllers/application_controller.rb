class ApplicationController < ActionController::Base
  protect_from_forgery

  #for captcha/secret-code box when registering as a user
  include SimpleCaptcha::ControllerHelpers

  before_filter :set_cache_buster


  #to ensure user can't see profile by clicking back after logging out
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end




  ###############
  #### DEVISE ###
  ###############


  #devise path for "after signing in"
  def after_sign_in_path_for(resource)
    if request.referrer && resource.is_a?(User)
      #unless path is one of the following (which will trigger infinite loops), go to root path
      case URI(request.referrer).path
      when '/users/sign_in', '/registrations/mustBe', '/sign_up', '/sign_in', '/users/sign_up', '/contacts' then 
        root_path
      else
        request.referrer
      end
    else
      root_path
    end

  end

  #devise path for "after signing out"
  def after_sign_out_path_for(resource)
    if request.referrer
      #unless path is one of the following (which will trigger infinite loops), go to root path
      case URI(request.referrer).path 
      when '/registrations/mustBe', '/reviews/new', '/users/profile', '/contacts' then
        root_path
      else
        request.referrer
      end
    else
      root_path
    end
  end
  
  # devise path for "after signing up"
  def after_sign_up_path_for(resource)
         "/users/profile"
  end
  
  # devise path for "after signing up but not confirmed"
  def after_inactive_sign_up_path_for(resource)
         "/registrations/email_confirm"
  end
  
  # after updating profile, send to "crop" page if new image, else profile
  def after_update_path_for(resource)
    if resource.crops
      "/users/#{resource.id}/crops"
    else
      "/users/profile"
    end
  end
  
  
  ####### TEXTILE & NO-TEXTILE #######

   # for un-textilizing textile/html text
   # so that it can be edited without the html tags in a textarea box
   def untextilized(textile)
     return Nokogiri::HTML.fragment(textile).text
   end

   # for textilizing plain text from a textarea box
   # so that newlines and formatting are preserved
   def textilized(text)
     return RedCloth.new( ActionController::Base.helpers.sanitize( text ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
   end




  ############################
  #### CUSTOM ERROR PAGES ####
  ############################

  #render pretty error pages when 404 or 500 status code appear
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
    rescue_from ActionController::UnknownController, :with => :render_not_found
    rescue_from AbstractController::ActionNotFound, :with => :render_not_found
  end


  private

  #write error to log & render 404 error page (in errors/error_404)
  def render_not_found(exception)
    Rails.logger.error("\nErrorPageRendered: #{exception.class} (#{exception.message}): #{Rails.backtrace_cleaner.clean(exception.backtrace).join("\n ")}")
    respond_to do |format|
      format.html { render 'errors/error_404', layout: 'layouts/application', status: 404 }
    end
  end

  #write error to log & render 500 error page (in errors/error_500)
  def render_error(exception)
    Rails.logger.error("\nErrorPageRendered: #{exception.class} (#{exception.message}): #{Rails.backtrace_cleaner.clean(exception.backtrace).join("\n ")}")
    respond_to do |format|
      format.html { render 'errors/error_500', layout: 'layouts/application', status: 500 }
    end
  end

end