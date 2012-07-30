class UserMailer < ActionMailer::Base  
  
  require 'rubygems'
  require 'madmimi'
  
  def confirmation_instructions(resource)
      @options = {"promotion_name" => "ConfirmEmail", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "VolunteerVoice Confirmation Email"}
      @yaml_body = {'instrux' => "girlpowerproject.herokuapp.com/confirmations/#{resource.confirmation_token}", 'usrname' => resource.username}
      @errors = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
      mail(:from => "no-reply@volunteervoice.org", :to => "sarahsponda902@gmail.com", :body => @errors)
  end
  
  def unlock_instructions(resource)
    @options = {"promotion_name" => "UnlockAccount", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "Unlock VolunteerVoice Account"}
    if resource.is_a?(OrganizationAccount)
       @yaml_body = {'instrux' => "girlpowerproject.herokuapp.com/organization_accounts/unlock?unlock_token=#{resource.unlock_token}", 'usrname' => resource.username}
    else
      @yaml_body = {'instrux' => "girlpowerproject.herokuapp.com/unlock?unlock_token=#{resource.unlock_token}", 'usrname' => resource.username}
    end
    @errors = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
   mail(:from => "no-reply@volunteervoice.org", :to => "sarahsponda902@gmail.com", :body => @errors)
  end
  
  def reset_password_instructions(resource)
    @options = {"promotion_name" => "ResetPassword", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "Reset Password on VolunteerVoice Account"}
    if resource.is_a?(OrganizationAccount)
       @yaml_body = {'instrux' => "girlpowerproject.herokuapp.com/organization_accounts/passwords/#{resource.reset_password_token}", 'usrname' => "#{resource.first_name} #{resource.last_name}"}
    else
       @yaml_body = {'instrux' => "girlpowerproject.herokuapp.com/passwords/#{resource.reset_password_token}", 'usrname' => resource.username}
    end
    @errors = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
    mail(:from => "no-reply@volunteervoice.org", :to => "sarahsponda902@gmail.com", :body => @errors)
  end
  
  def welcome_email(resource)
     @options = {"promotion_name" => "WelcomeEmail", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "Welcome to VolunteerVoice! You're Awesome."}
     @yaml_body = {'hme' => "girlpowerproject.herokuapp.com", 'usrname' => resource.username}
     @errors = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
     mail(:from => "no-reply@volunteervoice.org", :to => "sarahsponda902@gmail.com", :body => @errors)
  end
  
  def invitation_instructions(resource)
     @options = {"promotion_name" => "InvitationInstructions", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "Create Your VolunteerVoice Account"}
     @yaml_body = {'instrux' => "girlpowerproject.herokuapp.com/organization_accounts/invitation/accept?invitation_token=#{resource.invitation_token}", 'orgnme' => Organization.find(resource.organization_id).name}
     @errors = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
     mail(:from => "no-reply@volunteervoice.org", :to => "sarahsponda902@gmail.com", :body => @errors)
  end
  
end
