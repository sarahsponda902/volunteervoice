class InvitationsController < Devise::InvitationsController
  
  def create
    # this acts as a before_filter without copying the whole devise_invitable file
    if user_signed_in? && current_user.admin?
      super
    else
      redirect_to root_path
    end
  end

end