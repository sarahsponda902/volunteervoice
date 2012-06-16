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
    @options = {"promotion_name" => @mad_mimi_email.promotion_name, "recipients" => @mad_mimi_email.list_names, "from" => @mad_mimi_email.from, "subject" => @mad_mimi_email.subject}
    @yaml_body = {}
    @saved = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)

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
