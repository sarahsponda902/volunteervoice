class InvitationsController < Devise::InvitationsController
  before_filter :check_for_admin, :only => [:create]
  def create
    super
  end
  
  private
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
end