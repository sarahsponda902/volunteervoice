class MadMimiEmailsController < ApplicationController
  include ActionView::Helpers::TextHelper
  require 'rubygems'
  require 'madmimi'
  
  # GET /mad_mimi_emails
  # GET /mad_mimi_emails.json
  def index
    @mad_mimi_emails = MadMimiEmail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mad_mimi_emails }
    end
  end

  # GET /mad_mimi_emails/1
  # GET /mad_mimi_emails/1.json
  def show
    @mad_mimi_email = MadMimiEmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mad_mimi_email }
    end
  end

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
    
    @mad_mimi_email.list_names.each do |f|
      @options = {"promotion_name" => @mad_mimi_email.promotion_name, "recipients" => f[0], "from" => @mad_mimi_email.from, "subject" => @mad_mimi_email.subject}
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
end
