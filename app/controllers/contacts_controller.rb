class ContactsController < ApplicationController
include ActionView::Helpers::TextHelper
  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end


  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])
    @contact.body = RedCloth.new( ActionController::Base.helpers.sanitize( @contact.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html unless @contact.body.nil?
  
  respond_to do |format|  
    if @contact.to_whom == "request"
      @contact.is_request = true  
        if @contact.save(:validate => false)
          ContactMailer.to_request(@contact).deliver
          format.html { redirect_to "/pages/thank_you_request", notice: 'Contact was successfully sent.' }
          format.json { render json: @contact, status: :created, location: @contact }
        else
          flash[:notice] = flash[:notice].to_a.concat @contact.errors.full_messages
          format.html { render action: "new_request", notice: 'Error! Please make sure to include both your email and a message.' }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
    else
      if @contact.save
        if @contact.to_whom == "contact"
          ContactMailer.to_contact(@contact).deliver
        end
        if @contact.to_whom == "organizations"
          ContactMailer.to_organizations(@contact).deliver
        end
        if @contact.to_whom == "questions"
          ContactMailer.to_questions(@contact).deliver
        end
        
          format.html { redirect_to "/pages/thank_you", notice: 'Contact was successfully sent.' }
          format.json { render json: @contact, status: :created, location: @contact }
      else
        @contact.body = @contact.body.gsub(%r{</?[^>]+?>}, '') unless @contact.body.nil?
        flash[:notice] = flash[:notice].to_a.concat @contact.errors.full_messages

          format.html { render action: "new", notice: 'Error! Please make sure to include both your email and a message.' }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end
end

  def new_request
    @contact = Contact.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end


  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    if user_signed_in? && current_user.admin?
    respond_to do |format|
      format.html { redirect_to "/organization_accounts" }
      format.json { head :no_content }
    end
    else
      redirect_to root_path
    end
  end
end
