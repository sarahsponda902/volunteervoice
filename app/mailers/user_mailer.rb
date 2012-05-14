class UserMailer < ActionMailer::Base  
  
  require 'rubygems'
  require 'madmimi'
  
  def confirmation_instructions(resource)
      @options = {"promotion_name" => "ConfirmEmail", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "VolunteerVoice Confirmation Email"}
      @yaml_body = {'instrux' => "/confirmations/#{resource.confirmation_token}", 'usrname' => resource.username}
      MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
      mail(:from => "no-reply@volunteervoice.org")
  end
  
  def unlock_instructions(resource)
    @options = {"promotion_name" => "UnlockAccount", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "Unlock VolunteerVoice Account"}
    @yaml_body = {'instrux' => "/unlocks/#{resource.unlock_token}", 'usrname' => resource.username}
    MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
    mail(:from => "no-reply@volunteervoice.org")
  end
  
  def reset_password_instructions(resource)
    @options = {"promotion_name" => "ResetPassword", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "Reset Password on VolunteerVoice Account"}
    @yaml_body = {'instrux' => "/passwords/#{resouce.edit_password_token}", 'usrname' => resource.username}
    MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
    mail(:from => "no-reply@volunteervoice.org")
  end
  
  def welcome_email(resource)
     @options = {"promotion_name" => "WelcomeEmail", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "Welcome to VolunteerVoice! You're Awesome."}
     @yaml_body = {'hme' => root_path, 'usrname' => resource.username}
     MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
     mail(:from => "no-reply@volunteervoice.org")
  end
  
end
