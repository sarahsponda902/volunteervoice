class InvitationsController < Devise::InvitationsController
  def create
    if user_signed_in? && current_user.admin?
      super
    else
      redirect_to root_path
    end
  end
  
  def resend_invitation
    if user_signed_in? && current_user.admin?
      @user = params[:user_id]
      @user.invite!
      redirect_to "/organization_accounts"
    else
      redirect_to root_path
    end
  end
end