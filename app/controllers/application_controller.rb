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


  
  ####### DEVISE #######


  [:sign_in, :sign_out].each do |method|
    define_method "after_#{method}_path_for" do |resource|
      (loc = session[:return_to]).present? ? loc : root_path
    end
  end

  def after_sign_up_path_for(resource)
    "#{resource}s/profile"
  end
  
  def after_inactive_sign_up_path_for(resource)
     "registrations/email_confirm"
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

  [[:not_found, "404"], [:error, "500"]].each do |msg, error|
    define_method "render_#{msg.to_s}" do |exception|
      Rails.logger.error("\nErrorPageRendered: #{exception.class} (#{exception.message}): #{Rails.backtrace_cleaner.clean(exception.backtrace).join("\n ")}")
      respond_to do |format|
        format.html { render "errors/error_#{error}", layout: 'layouts/application', status: error.to_i }
      end
    end
  end

end