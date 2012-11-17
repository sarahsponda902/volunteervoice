class RegistrationsController < Devise::RegistrationsController 
  #######################################################################
  ### Written (mostly) by Platformatec                           ########
  ### in Devise gem at:  https://github.com/plataformatec/devise ########
  #######################################################################

  include SimpleCaptcha::ControllerHelpers
  include ActionView::Helpers::TextHelper

  skip_before_filter :require_no_authentication 

  def new
    session[:return_to] = request.referrer
    super
  end
  
  def create
    build_resource # devise method
    if resource.save_with_captcha # save if captcha (secret code) is correct on register page
      if resource.confirmed? # if email confirmation link has been clicked by user in email
        set_flash_message :notice, :signed_up if is_navigational_format? #unused, but kept for future use
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      flash[:notice] = flash[:notice].to_a.concat resource.errors.full_messages
      clean_up_passwords resource
      respond_with resource
    end
  end

  # mostly devise-written, but staff added update_with_password to allow users to
  #   update fields (except password field) without entering a password
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    # update_with_password is defined in user model
    if resource.update_with_password(params[resource_name])
      if is_navigational_format?
        if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
          flash_key = :update_needs_confirmation
        end
        set_flash_message :notice, flash_key || :updated
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      flash[:notice] = flash[:notice].to_a.concat resource.errors.full_messages
      redirect_to "/users/profile"
    end
  end


  # after registration, user sent to 'thank you' page that discusses how to confirm
  #  with the email link
  def email_confirm
  end


  # page user is sent to to confirm that they really want to leave VVI and cancel their registration
  def are_you_sure
  end

  # page user is sent to when they try to acces something they shouldn't because they are not logged in
  # page includes both a register and a login form
  def must_be
    resource = build_resource({})
    session[:return_to] = request.referrer
    respond_with resource
  end
      

end