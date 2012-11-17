class ContactsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :check_for_admin, :only => [:destroy]
  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new
    session[:return_to] = request.referrer
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end


  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])

    ## Textilize body
    @contact.body = RedCloth.new( ActionController::Base.helpers.sanitize( @contact.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html unless @contact.body.nil?

    respond_to do |format|  
      ## if contact is an organization's account request
      if @contact.to_whom == "request"
        @contact.is_request = true ## for methods in model 
        if @contact.save(:validate => false)  ## does not need same validations as regular contact email

          ContactMailer.to_request(@contact).deliver
          format.html { redirect_to "/organization_accounts/thank_you_request", notice: 'Contact was successfully sent.' }
          format.json { render json: @contact, status: :created, location: @contact }
        else ## if there is some error (which there shouldn't be, this was mainly for testing)
          flash[:notice] = flash[:notice].to_a.concat @contact.errors.full_messages
          format.html { redirect_to "/organization_accounts/new_request"} ## send to new account request page
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      else ## if contact is not an account request
        if @contact.save

          ## There are four emails that a contact email can be sent to:
          #### Contact - for a general 'contact us' inquiry/comment
          #### Organizations - for organizations to inquire to staff
          #### Questions - for general questions for staff
          #### Feedback - for after a user/organization has unsubscribed, feedback on why they unsubscribed to the mailing list

          if @contact.to_whom == "contact" 
            ContactMailer.to_contact(@contact).deliver
          elsif @contact.to_whom == "organizations"
            ContactMailer.to_organizations(@contact).deliver
          elsif @contact.to_whom == "questions"
            ContactMailer.to_questions(@contact).deliver
          else @contact.to_whom == "feedback"
            ContactMailer.to_feedback(@contact).deliver
          end

          format.html { redirect_to "/contacts/thank_you", notice: 'Contact was successfully sent.' }
          format.json { render json: @contact, status: :created, location: @contact }

        else ## if contact is not saved (invalid)
          ## Un-textilize the body so it appears normally in textarea
          @contact.body = Nokogiri::HTML.fragment(@contact.body).text unless @contact.body.nil?
          flash[:notice] = flash[:notice].to_a.concat @contact.errors.full_messages

          format.html { render action: "new", notice: 'Error! Please make sure to include both your email and a message.' }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end #format block
      end #end if save
    end #end if request
  end


  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to "/organization_accounts" }
      format.json { head :no_content }
    end
  end

  private
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
end
