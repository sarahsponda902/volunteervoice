class ContactMailer < ActionMailer::Base
  require 'rubygems'
  require 'madmimi'

  default :from => "noreply@volunteervoice.org"

  ["contact", "organizations", "questions", "feedback"].each do |mailer_method|
    define_method "to_#{mailer_method}" do |message|
      @message = message
      @user_path = "http://www.volunteervoice.org/users/#{@message.user_id}"
      if mailer_method != "feedback"
        mail(:subject => "Contact Us: #{message.subject}", :to => "#{mailer_method}@volunteervoice.org")
      else
        mail(:subject => "Contact Us: #{message.subject}", :to => "contact@volunteervoice.org")
    end
  end

  def to_request(contact)
    @options = {"promotion_name" => "RequestEmail", "recipient" => "request@volunteervoice.org", "from" => "no-reply@volunteervoice.org", "subject" => "New Request"}
    @yaml_body = {'organization_name' => contact.organization_name, 'country' => contact.country, 'url' => contact.organization_url, 'has_profile' => contact.has_profile, 'main_contact' => contact.main_contact, 'position' => contact.position_of_contact, 'email' => contact.email}
    # send both madmimi email & actionmailer email to request@volunteervoice.org
    @errors = MadMimi.new(ENV['MAD_MIMI_EMAIL'], ENV['MAD_MIMI_KEY']).send_mail(@options, @yaml_body)
    mail(:subject => "New Request for #{@organization_name}", :to => "request@volunteervoice.org")
  end
end
