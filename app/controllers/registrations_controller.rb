class RegistrationsController < Devise::RegistrationsController 
  
  skip_before_filter :require_no_authentication 
  
  include SimpleCaptcha::ControllerHelpers
  include ActionView::Helpers::TextHelper
  def after_sign_up_path_for(resource)
         "/users/profile"
  end
  
  def after_inactive_sign_up_path_for(resource)
         "/registrations/email_confirm"
  end

  def create
    build_resource 
    resource.unread_messages = 0
    resource.admin_pass = Digest::SHA1.hexdigest("#{salt}:#{resource.admin_pass}") 
    if resource.admin_pass == "4e5d0ed9183ebf2fed541412497e15a30e72f9cb" && resource.admin_update == true
      resource.admin = true;
    end
    resource.messages_show = false
    resource.profile_show = false
     if (resource.email == resource.email_confirmation) && resource.save_with_captcha
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
      flash[:notice] = flash[:notice].to_a.concat resource.errors.full_messages
      flash.now[:notice] = flash[:notice].to_a.concat resource.errors.full_messages
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
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

  
  def email_confirm
  end
  
  def are_you_sure
  end
  
  def must_be
    resource = build_resource({})
    respond_with resource
  end
  
   
   def after_update_path_for(resource)
     if resource.crops
       "/users/#{resource.id}/crops"
     else
       "/users/profile"
     end
   end


  private
  
    def salt
      return "meeQue8Zucijoo7"
    end

  
end