class ContactsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :check_for_admin, :only => [:destroy]
  respond_to :html, :json
  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new
    session[:return_to] = request.referrer
    respond_with @contact
  end


  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])
    @contact.body = RedCloth.new( ActionController::Base.helpers.sanitize( @contact.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html unless @contact.body.nil?

    if @contact.to_whom == "request"
      @contact.is_request = true 
      ContactMailer.to_request(@contact).deliver
      redirect_to "organization_accounts/thank_you_request"
    elsif (errors = @contact.any_errors?).empty?
      case @contact.to_whom 
      when "contact" then ContactMailer.to_contact(@contact).deliver
      when "organizations" then ContactMailer.to_organizations(@contact).deliver
      when "questions" then ContactMailer.to_questions(@contact).deliver
      when "feedback" then ContactMailer.to_feedback(@contact).deliver
      end
      redirect_to "contacts/thank_you"
    else ## if contact is invalid
      @contact.body = Nokogiri::HTML.fragment(@contact.body).text unless @contact.body.nil?
      flash[:notice] = flash[:notice].to_a.concat errors
      respond_with @contact
    end #end if
  end #end create


  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    respond_with @contact do
      redirect_to organization_accounts_path
    end
  end

  private
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
end
