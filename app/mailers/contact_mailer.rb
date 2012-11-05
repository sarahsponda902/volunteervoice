class ContactMailer < ActionMailer::Base
  require 'rubygems'
  require 'madmimi'

  default :from => "noreply@volunteervoice.org"
  default :to => "contact@volunteervoice.org"

  # regular contact_us mailer
  # sends a message to contact@volunteervoice.org
  # user can send a contact_us at /contacts/new
  def to_contact(message)
    @message = message
    @user_path = "http://www.volunteervoice.org/users/#{@message.user_id}"
    mail(:subject => "Contact Us: #{message.subject}")
  end

  # contact_us mailer for organizations
  # sends a message to organizations@volunteervoice.org
  # organization can send a contact_us at /contacts/new
  def to_organizations(message)
    @message = message
    @user_path = "http://www.volunteervoice.org/users/#{@message.user_id}"
    mail(:subject => "Contact Us: #{message.subject}", :to => "organizations@volunteervoice.org")
  end

  # contact_us mailer for questions/inquiries 
  # sends a message to questions@volunteervoice.org
  # user can send a contact_us at /contacts/new
  def to_questions(message)
    @message = message
    @user_path = "http://www.volunteervoice.org/users/#{@message.user_id}"
    mail(:subject => "Contact Us: #{message.subject}", :to => "questions@volunteervoice.org")
  end


  # feedback mailer that sends a message to contact@volunteervoice.org
  # user can send a feedback after they succesfully unsubscribe from the mailing list
  # feedbacks are for descriptions on WHY the user/org_account wanted to unsubscribe
  # NOTE: THIS IS NOT THE HOMEPAGE FEEDBACK
  def to_feedback(message)
    @message = message
    @user_path = "http://www.volunteervoice.org/users/#{@message.user_id}"
    mail(:subject => "Unsubscribe: #{message.subject}", :to => "contact@volunteervoice.org")
  end


  # account_request mailer that sends a message to request@volunteervoice.org
  # organization can request an account via a popup on the homepage
  def to_request(contact)
    @options = {"promotion_name" => "RequestEmail", "recipient" => "request@volunteervoice.org", "from" => "no-reply@volunteervoice.org", "subject" => "New Request"}
    @yaml_body = {'organization_name' => contact.organization_name, 'country' => contact.country, 'url' => contact.organization_url, 'has_profile' => contact.has_profile, 'main_contact' => contact.main_contact, 'position' => contact.position_of_contact, 'email' => contact.email}
    # send both madmimi email & actionmailer email to request@volunteervoice.org
    @errors = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
    mail(:subject => "New Request for #{@organization_name}", :to => "request@volunteervoice.org")
  end
end
