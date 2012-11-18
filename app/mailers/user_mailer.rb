class UserMailer < ActionMailer::Base  
  # Note: emails delivered by madmimi to user/organization_account
  #       errors (or message id# if no errors) delivered by sendgrid to sarah@volunteervoice.org
  require 'rubygems'
  require 'madmimi'


  # confirmation_instructions sent to users to confirm their account before they can log in
  def confirmation_instructions(resource)
    @options = {"promotion_name" => "ConfirmEmail", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "VolunteerVoice Confirmation Email"}
    @yaml_body = {'instrux' => "http://volunteervoice.org/confirmations/#{resource.confirmation_token}", 'usrname' => resource.username, 'otherlink' => "http://www.volunteervoice.org"}
    @errors = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
    mail(:from => "no-reply@volunteervoice.org", :to => "sarah@volunteervoice.org", :body => @errors)
  end

  # unlock_instructions sent to users AND organization_accounts if they lock their account
  # an account is locked if the password is guessed incorrectly 10 times
  def unlock_instructions(resource)
    @options = {"promotion_name" => "UnlockAccount", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "Unlock VolunteerVoice Account"}
    if resource.is_a?(OrganizationAccount)
      @yaml_body = {'instrux' => "http://volunteervoice.org/organization_accounts/unlock?unlock_token=#{resource.unlock_token}", 'usrname' => resource.username}
    else
      @yaml_body = {'instrux' => "http://volunteervoice.org/unlock?unlock_token=#{resource.unlock_token}", 'usrname' => resource.username}
    end
    @errors = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
    mail(:from => "no-reply@volunteervoice.org", :to => "sarah@volunteervoice.org", :body => @errors)
  end

  # reset_password_instructions sent to users AND organization_accounts if they forget their password
  def reset_password_instructions(resource)
    @options = {"promotion_name" => "ResetPassword", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "Reset Password on VolunteerVoice Account"}
    if resource.is_a?(OrganizationAccount)
      @yaml_body = {'instrux' => "http://volunteervoice.org/organization_accounts/passwords/#{resource.reset_password_token}", 'usrname' => "#{resource.first_name} #{resource.last_name}"}
    else
      @yaml_body = {'instrux' => "http://volunteervoice.org/passwords/#{resource.reset_password_token}", 'usrname' => resource.username}
    end
    @errors = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
    mail(:from => "no-reply@volunteervoice.org", :to => "sarah@volunteervoice.org", :body => @errors)
  end

  # invitation_instructions are sent to an organization to create their organization_account
  # (although it appears they are creating the account, it has actually already been created. They are updating it.)
  def invitation_instructions(resource)
    @options = {"promotion_name" => "InvitationInstructions", "recipient" => resource.email, "from" => "no-reply@volunteervoice.org", "subject" => "Create Your VolunteerVoice Account"}
    @yaml_body = {'instrux' => "http://volunteervoice.org/organization_accounts/invitation/accept?invitation_token=#{resource.invitation_token}", 'orgnme' => Organization.find(resource.organization_id).name}
    @errors = MadMimi.new("sarahsponda902@gmail.com", 'df65cf0a215c2b3028fa7eaf89a6f2ba').send_mail(@options, @yaml_body)
    mail(:from => "no-reply@volunteervoice.org", :to => "sarah@volunteervoice.org", :body => @errors)
  end

end
