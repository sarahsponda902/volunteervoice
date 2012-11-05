class UsersController < ApplicationController

  include ActionView::Helpers::TextHelper
  require 'aws/s3'

  before_filter :authenticate_user!, :only => [:crop, :profile, :update]
  before_filter :check_for_admin, :only => [:index, :make_admin]

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
    @users = User.all
    @users = @users.sort_by(&:created_at).reverse
    @unapproved_users = User.where(:approved => false)
    @approved_users = User.where(:approved => true)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show  
    @user = User.find(params[:id])
    @reviews = @user.reviews

    # if user tries to look at their own user profile, send them to the profile page instead
    if user_signed_in? && (@user.id == current_user.id)
      redirect_to "/users/profile"
    else
      # setup for another user to send this user a message
      @message = Message.new

      # setup for another user to flag this user's reviews
      @flag = Flag.new

      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @user }
      end

    end # end if statement
  end
  
  # a user's own profile
  def profile
    @user = User.find(current_user.id)
    
    # setup for a "reply" message to another user
    @message = Message.new
    
    # to see if a message can be replied to, check if user_id is in the list of all user ids
    @user_ids = User.all.map(&:id)
    
    # to show 'my reviews', 'my favorites', 'my messages', and 'my sent messages'
    @reviews = @user.reviews.order("created_at DESC")
    @favorites = @user.favorites
    @messages = ::Message.where(:recipient_id => current_user.id, :recipient_deleted => false).sort_by(&:created_at).reverse
    @sent_messages = ::Message.where(:sender_id => current_user.id, :sender_deleted => nil).sort_by(&:created_at).reverse
  end


  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if (current_user == @user || current_user.admin?) && @user.update_attributes(params[:user])
      if @user.crops # if new image has been uploaded
        redirect_to "/users/#{@user.id}/crop" # send to crop page
      else
        flash[:notice] = 'Your profile was successfully updated.'
        redirect_to("/users/profile")
      end
    else
      flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
      respond_to do |format|
        format.html { redirect_to "/users/edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
  end

  # called by a user clicking the unsubscribe link in a newsletter email
  # will change the subscription status to the oposite of what it is currently
  # ex: (does_not_receive_newsletter) => (receives_newsletter)
  def change_subscription
    @user = User.find(params[:id])
    @user.notify = !@user.notify
    @user.save
    respond_to do |format|
      format.html {render :action => "successful_unsubscribe"}
      format.json {head :no_content}
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

end
