class UsersController < ApplicationController

  include ActionView::Helpers::TextHelper
  require 'aws/s3'

  before_filter :authenticate_user!, :only => [:crop, :profile, :update]
  before_filter :check_for_admin, :only => [:index, :make_admin]
  before_filter :check_for_user, :only => [:show]
  respond_to :html, :json

  helper :all
  helper_method :age

  # user comes to this page after uploading a new photo
  # to crop their photo
  def crop
    @user = current_user
  end

  # GET /users
  # GET /users.json
  # Admin only index of users
  def index
    @users = User.order('created_at desc')
    @unapproved_users = User.where(:approved => false)
    @approved_users = User.where(:approved => true)
    respond_with(@users)
  end

  # GET /users/1
  # GET /users/1.json
  def show  
    @reviews = @user.reviews
    @message = Message.new
    @flag = Flag.new
    respond_with(@user)
  end
  
  # a user's own profile
  def profile
    @presenter = Users::ProfilePresenter.new
    @message = Message.new
  end


  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    
    respond_with(@user) do
      if (saved = @user.update_attributes(params[:user])) && @user.crops
        redirect_to "/users/#{@user.id}/crop"
      elsif saved
        flash[:notice] = 'Your profile was successfully updated.'
        redirect_to("/users/profile")
      end
    end
  end



  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
      @user = User.find(params[:id])
      @user.destroy
      respond_with(@user)
  end

  # called by a user clicking the unsubscribe link in a newsletter email
  # will change the subscription status to the oposite of what it is currently
  # ex: (does_not_receive_newsletter) => (receives_newsletter)
  def change_subscription
    @user = User.find(params[:id])
    @user.notify = !@user.notify
    @user.save
    respond_with(@user) do
      redirect_to "/users/successful_unsubscribe"
    end
  end

  # page a user is sent to when they have unsubscribed from the newsletter
  def successful_unsubscribe
  end


  # Admin only method to make another user an admin
  def make_admin
    @user = User.find(params[:user_id])
    @user.admin = !@user.admin
    @user.save
    redirect_to users_path
  end

  private
  ## check_for_admin called by before_filter
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
  
  def check_for_user
    @user = User.find(params[:id])
    if current_user == @user
      redirect_to "/pages/profile"
    end
  end

end
