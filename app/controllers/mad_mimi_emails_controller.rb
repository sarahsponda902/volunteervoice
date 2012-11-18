class MadMimiEmailsController < ApplicationController
  include ActionView::Helpers::TextHelper
  require 'madmimi'
  respond_to :html, :json
  before_filter :check_for_admin

  # GET /mad_mimi_emails/new
  # GET /mad_mimi_emails/new.json
  def new
    @mad_mimi_email = MadMimiEmail.new
    @mimi = MadMimi.new(ENV['MAD_MIMI_EMAIL'], ENV['MAD_MIMI_KEY'])
    @promotions = @mimi.promotions
    @emails = User.where(:notify => true).map(&:email)
    respond_with(@mad_mimi_email)
  end

  # POST /mad_mimi_emails
  # POST /mad_mimi_emails.json
  def create
    @mad_mimi_email = MadMimiEmail.new(params[:mad_mimi_email])
    @mad_mimi_email.list_names = @mad_mimi_email.get_list_names
    
    # Madmimi gem will only send one email at a time, so must iterate through names & send
    @mad_mimi_email.list_names.each do |person|
      @options = {"promotion_name" => @mad_mimi_email.promotion_name, "recipients" => person[0], 
        "from" => @mad_mimi_email.from, "subject" => @mad_mimi_email.subject }
      @yaml_body = f[1]
      @saved = MadMimi.new(ENV['MAD_MIMI_EMAIL'], ENV['MAD_MIMI_KEY']).send_mail(@options, @yaml_body)
    end
    respond_with(@mad_mimi_email)
  end

  # DELETE /mad_mimi_emails/1
  # DELETE /mad_mimi_emails/1.json
  def destroy
    @mad_mimi_email = MadMimiEmail.find(params[:id])
    @mad_mimi_email.destroy
    respond_with(@mad_mimi_email)
  end
  
  private
  # called by before_filter
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
end
