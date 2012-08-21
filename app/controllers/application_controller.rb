class ApplicationController < ActionController::Base
  protect_from_forgery

  include SimpleCaptcha::ControllerHelpers

  #devise path for "after signing in"
  def after_sign_in_path_for(resource)
    if request.referrer
      case URI(request.referrer).path
      when '/users/sign_in', '/registrations/mustBe', '/sign_up', '/sign_in', '/users/sign_up', '/contacts' then
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
      when '/registrations/mustBe', '/reviews/new', '/users/profile', '/contacts' then
        '/'
      else
        request.referrer
      end
    else
      '/'
    end
  end


  def method_missing(m, *args, &block)
    Rails.logger.error(m)
    notify_airbrake(m)
    respond_to do |format|
      format.html { render 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  #render pretty error pages when 404 or 500 status code appear
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
    rescue_from ActionController::UnknownController, :with => :render_not_found
    rescue_from AbstractController::ActionNotFound, :with => :render_not_found
  end


  private

  def render_not_found(exception)
    Rails.logger.error("\nErrorPageRendered: #{exception.class} (#{exception.message}): #{Rails.backtrace_cleaner.clean(exception.backtrace).join("\n ")}")
    notify_airbrake(exception)
    respond_to do |format|
      format.html { render 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_error(exception)
    Rails.logger.error("\nErrorPageRendered: #{exception.class} (#{exception.message}): #{Rails.backtrace_cleaner.clean(exception.backtrace).join("\n ")}")
    notify_airbrake(exception)
    respond_to do |format|
      format.html { render 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500 }
    end
  end

end