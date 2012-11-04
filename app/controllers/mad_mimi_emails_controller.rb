class MadMimiEmailsController < ApplicationController
  include ActionView::Helpers::TextHelper
  require 'rubygems'
  require 'madmimi'
  before_filter :check_for_admin

  # GET /mad_mimi_emails/new
  # GET /mad_mimi_emails/new.json
  def new
    @mad_mimi_email = MadMimiEmail.new
    @mimi = MadMimi.new('sarahsponda902@gmail.com', 'df65cf0a215c2b3028fa7eaf89a6f2ba')
    @promotions = @mimi.promotions
    @emails = User.where(:notify => true).map(&:email)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mad_mimi_email }
    end
  end

  # POST /mad_mimi_emails
  # POST /mad_mimi_emails.json
  def create
    @mad_mimi_email = MadMimiEmail.new(params[:mad_mimi_email])
    if @mad_mimi_email.list_names == "users"
      @mad_mimi_email.list_names = User.where(:notify => true).map{|user| [user.email, {'username' => user.username, 'email' => user.email, 'unsubscribe_link' => "girlpowerproject.herokuapp.com/users/#{user.id}/change_subscription"}]}
    end
    if @mad_mimi_email.list_names == "admins"
      @mad_mimi_email.list_names = User.where(:admin => true).map{|admin| [admin.email, {'username' => admin.username, 'email' => admin.email}]}
    end
    if @mad_mimi_email.list_names == "organizations"
      @mad_mimi_email.list_names = OrganizationAccount.where(:notify => true).map{|org| [org.email, {'firstname' => org.first_name, 'lastname' => org.last_name, 'position' => org.position, 'email' => org.email, 'username' => org.username, 'country' => org.country, 'organization_name' => Organization.find(org.organization_id).name, 'unsubscribe_link' => "girlpowerproject.herokuapp.com/organization_accounts/#{user.id}/change_subscription"}]}
    end
    
    # Madmimi gem will only send one email at a time, so must iterate through names & send
    @mad_mimi_email.list_names.each do |f|
      @options = {"promotion_name" => @mad_mimi_email.promotion_name, "recipients" => f[0], "from" => @mad_mimi_email.from, "subject" => @mad_mimi_email.subject}
      
      # @yaml_body is a hash with all the replacement keywords for the madmimi email created in the promomotion
      @yaml_body = f[1]
      @saved = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
    end
    respond_to do |format|
      if @mad_mimi_email.save
        format.html { redirect_to @mad_mimi_email, notice: 'Mad mimi email was successfully created.', :notice => @saved }
        format.json { render json: @mad_mimi_email, status: :created, location: @mad_mimi_email }
      else
        format.html { render action: "new" }
        format.json { render json: @mad_mimi_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mad_mimi_emails/1
  # DELETE /mad_mimi_emails/1.json
  def destroy
    @mad_mimi_email = MadMimiEmail.find(params[:id])
    @mad_mimi_email.destroy

    respond_to do |format|
      format.html { redirect_to mad_mimi_emails_url }
      format.json { head :no_content }
    end
  end
  
  private
  # called by before_filter
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
end
