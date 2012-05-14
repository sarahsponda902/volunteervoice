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
end
