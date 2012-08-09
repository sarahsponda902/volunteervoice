class UsersController < ApplicationController
  
  include ActionView::Helpers::TextHelper
	require 'aws/s3'
  
  helper :all
  helper_method :age
  
  def crop
    if user_signed_in?
      @user = current_user
    else
      redirect_to "/pages/blogs"
    end
  end
  
  # GET /users
  # GET /users.json
  def index
   
    
    if user_signed_in? && current_user.admin?
    @users = User.all
    @unapproved_users = User.where(:approved => false)
    @approved_users = User.where(:approved => true)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  else
    redirect_to root_path
  end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    
    @user = User.find(params[:id])
    if user_signed_in? && (@user.id == current_user.id)
    redirect_to "/pages/profile"
    else
    @message = Message.new
    @flag = Flag.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
      
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
        @user = User.find(params[:id])
        
        if @user.update_attributes(params[:user])
          if @user.crops
             redirect_to "/users/#{@user.id}/crop"
          else
             flash[:notice] = 'Your profile was successfully updated.'
             redirect_to("/pages/profile")
          end
        else
          flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
          respond_to do |format|
            format.json { render json: @user.errors, status: :unprocessable_entity }
            format.html { redirect_to "/pages/profile", :notice => 'notice' }
          end
        end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if user_signed_in? && current_user.admin?
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  else
    redirect_to root_path
  end
  end
  
  def destroy_image
    @user.save
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'Image was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit"}
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def check_email
  @user = User.find_by_email(params[:user][:email])

  respond_to do |format|
  format.json { render :json => !@user }
  end
  end
  
  def check_username
    @user = User.find_by_email(params[:user][:username])

    respond_to do |format|
      format.json { render :json => !@user }
    end
  end

  def change_subscription
    @user = User.find(params[:id])
    @user.notify = !@user.notify unless @user.notify.nil?
    @user.save
    respond_to do |format|
      format.html {render :action => "successful_unsubscribe"}
      format.json {head :no_content}
    end
  end
  
  
  def successful_unsubscribe
  end

  def make_admin
    if !(user_signed_in? && current_user.admin?)
      redirect_to root_path
    else
      @user = User.find(params[:user_id])
      if !@user.admin?
        @user.admin = true
      else
        @user.admin = false
      end
      @user.save
      redirect_to "/users"
    end
  end

end
