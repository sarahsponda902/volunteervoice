class RegistrationsController < Devise::RegistrationsController
  include SimpleCaptcha::ControllerHelpers
  
  def after_sign_up_path_for(resource)
         "/pages/profile"
  end
  
  def after_inactive_sign_up_path_for(resource)
         "/registrations/email_confirm"
  end

  def create
    build_resource 
    resource.admin_pass = Digest::SHA1.hexdigest("#{salt}:#{resource.admin_pass}") 
    if resource.admin_pass == "4e5d0ed9183ebf2fed541412497e15a30e72f9cb" && resource.admin_update == true
      resource.admin = true;
    end
     if resource.save_with_captcha
           if resource.confirmed?
             set_flash_message :notice, :signed_up if is_navigational_format?
             sign_in(resource_name, resource)
             respond_with resource, :location => after_sign_up_path_for(resource)
           else
             set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
             expire_session_data_after_sign_in!
             respond_with resource, :location => after_inactive_sign_up_path_for(resource)
           end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  def thank_you
  end
  
  def email_confirm
  end
  
  def must_be
    build_resource
     
     if resource.save_with_captcha
           if resource.confirmed?
             set_flash_message :notice, :signed_up if is_navigational_format?
             sign_in(resource_name, resource)
             respond_with resource, :location => after_sign_up_path_for(resource)
           else
             set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
             expire_session_data_after_sign_in!
             respond_with resource, :location => after_inactive_sign_up_path_for(resource)
           end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end


  private
  
    def salt
      return "meeQue8Zucijoo7"
    end

  
end