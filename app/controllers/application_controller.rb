class ApplicationController < ActionController::Base
  protect_from_forgery

  include SimpleCaptcha::ControllerHelpers

#devise path for "after signing in"
  def after_sign_in_path_for(resource)
    if request.referrer
      case URI(request.referrer).path
      when '/users/sign_in', '/registrations/mustBe', '/sign_up', '/sign_in', '/users/sign_up' then
        '/'
      else
        request.referrer
      end
    else
      '/'
    end

  end

#devise path for "after signing out"
  def after_sign_out_path_for(resource)
    if request.referrer
      case URI(request.referrer).path 
      when '/registrations/mustBe', '/reviews/new', '/users/profile' then
        '/'
      else
        request.referrer
      end
    else
      '/'
    end


#render pretty error pages when 404 or 500 status code appear
  def render_optional_error_file(status_code)
    case status_code
    when :not_found then
      render :controller => "errors", :action => "error_404"
    when "500" then
     render :controller => "errors", :action => "error_500"
    else
      super
    end

  end

end
