class Contact < ActiveRecord::Base
  validate :present_email_and_body
  validate :length_of_body
  validate :format_of_email
  
  def present_email_and_body
    if is_request.nil?
      if body.nil?
        errors.add(:body, "cannot be blank")
      end
      if email.nil?
        errors.add(:email, "cannot be blank")
      end
    end
  end
  
  def length_of_body
    if is_request.nil?
      if body.length < 5
        errors.add(:body, "must be more than 5 characters")
      end
    end
  end
  
  def format_of_email
    @email_format = Regexp.new(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/)
    if is_request.nil?
      if !(@email_format.match(email))
        errors.add(:email, "must be a valid email address")
      end
    end
  end
end