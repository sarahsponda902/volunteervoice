class UserMailer < MadMimiMailer
  
  def confirm(resource)
    subject "VolunteerVoice Confirmation Email"
    recipients resource.email
    from "no-reply@volunteervoice.org"
    body :instrux => "girlpowerproject.herokuapp.com/confirmations/#{resource.confirmation_token}", :usrname => resource.username
  end
  
  def unlockorg(resource)
    recipients resource.email
    from "no-reply@volunteervoice.org"
    subject "Unlock VolunteerVoice Account"
    body :instrux => "girlpowerproject.herokuapp.com/organization_accounts/unlock?unlock_token=#{resource.unlock_token}", :usrname => resource.username
  end
  
  
  def unlock(resource)
    recipients resource.email
    from "no-reply@volunteervoice.org"
    subject "Unlock VolunteerVoice Account"
    body = :instrux => "girlpowerproject.herokuapp.com/unlock?unlock_token=#{resource.unlock_token}", :usrname => resource.username
  end
  
  def passwordorg(resource)
    recipients resource.email
    from "no-reply@volunteervoice.org"
    subject "Reset Password on VolunteerVoice Account"
    body :instrux => "girlpowerproject.herokuapp.com/organization_accounts/passwords/#{resource.reset_password_token}", :usrname => "#{resource.first_name} #{resource.last_name}"
  end
  
  def password(resource)
    recipients resource.email
    from "no-reply@volunteervoice.org"
    subject "Reset Password on VolunteerVoice Account"
    body :instrux => "girlpowerproject.herokuapp.com/passwords/#{resource.reset_password_token}", :usrname => resource.username
  end
  
  def welcome(resource)
     recipients resource.email
     from "no-reply@volunteervoice.org"
     subject "Welcome to VolunteerVoice! You're Awesome."
     body :hme => "girlpowerproject.herokuapp.com", :usrname => resource.username
  end
  
  def invitation(resource)
     recipients resource.email
     from "no-reply@volunteervoice.org"
     subject "Create Your VolunteerVoice Account"
     body :instrux => "girlpowerproject.herokuapp.com/organization_accounts/invitation/accept?invitation_token=#{resource.invitation_token}", :orgnme => Organization.find(resource.organization_id).name}
  end
  
end
