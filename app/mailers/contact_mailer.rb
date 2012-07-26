class ContactMailer < ActionMailer::Base
  default :from => "noreply@volunteervoice.org"
  default :to => "contact@volunteervoice.org"

  def to_contact(message)
    @message = message
    @user_path = "http://localhost:3000/users/#{@message.user_id}"
    mail(:subject => "Contact Us: #{message.subject}")
  end
  
  def to_organizations(message)
     @message = message
     @user_path = "http://localhost:3000/users/#{@message.user_id}"
      mail(:subject => "Contact Us: #{message.subject}", :to => "organizations@volunteervoice.org")
  end
  
  def to_questions(message)
      @message = message
      @user_path = "http://localhost:3000/users/#{@message.user_id}"
       mail(:subject => "Contact Us: #{message.subject}", :to => "questions@volunteervoice.org")
  end
   
  def to_organizations(message)
     @message = message
     @user_path = "http://localhost:3000/users/#{@message.user_id}"
     mail(:subject => "Unsubscribe: #{message.subject}", :to => "feedback@volunteervoice.org")
  end
   
   def to_request(contact)
       @organization_name = contact.organization_name
       @country = contact.country
       @url = contact.organization_url
       @has_profile = contact.has_profile
       @main_contact = contact.main_contact
       @position = contact.position_of_contact
       @email = contact.contact_email
       mail(:subject => "New Request for #{@organization_name}", :to => "request@volunteervoice.org")
    end
end
