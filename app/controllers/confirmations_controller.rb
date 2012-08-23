class ConfirmationsController < Devise::ConfirmationsController 
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    resource.unread_messages = 1
    super
  end
end