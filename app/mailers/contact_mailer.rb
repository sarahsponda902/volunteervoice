class ContactMailer < ActionMailer::Base
  require 'rubygems'
  require 'madmimi'
  
  default :from => "noreply@volunteervoice.org"
  default :to => "contact@volunteervoice.org"

  def to_contact(message)
    @message = message
    @user_path = "http://girlpowerproject.herokuapp.com/users/#{@message.user_id}"
    mail(:subject => "Contact Us: #{message.subject}")
  end
  
  def to_organizations(message)
     @message = message
     @user_path = "http://girlpowerproject.herokuapp.com/users/#{@message.user_id}"
      mail(:subject => "Contact Us: #{message.subject}", :to => "organizations@volunteervoice.org")
  end
  
  def to_questions(message)
      @message = message
      @user_path = "http://girlpowerproject.herokuapp.com/users/#{@message.user_id}"
       mail(:subject => "Contact Us: #{message.subject}", :to => "questions@volunteervoice.org")
  end
   
  def to_organizations(message)
     @message = message
     @user_path = "http://girlpowerproject.herokuapp.com/users/#{@message.user_id}"
     mail(:subject => "Unsubscribe: #{message.subject}", :to => "contact@volunteervoice.org")
  end
   
   def to_request(contact)
       @organization_name = contact.organization_name
       @country = contact.country
       @url = contact.organization_url
       @has_profile = contact.has_profile
       @main_contact = contact.main_contact
       @position = contact.position_of_contact
       @email = contact.email
       
       @options = {"promotion_name" => "RequestEmail", "recipient" => "request@volunteervoice.org", "from" => "no-reply@volunteervoice.org", "subject" => "New Request"}
        @yaml_body = {'organization_name' => @organization_name, 'country' => @country, 'url' => @url, 'has_profile' => @has_profile, 'main_contact' => @main_contact, 'position' => @position, 'email' => @email}
        @errors = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
       mail(:subject => "New Request for #{@organization_name}", :to => "request@volunteervoice.org")
    end
end
