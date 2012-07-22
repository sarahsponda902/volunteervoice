class InvitationsController < Devise::InvitationsController
  def create
    if user_signed_in? && current_user.admin?
      super
    else
      redirect_to root_path
    end
  end

end