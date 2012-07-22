class Contact < ActiveRecord::Base
  validates_presence_of :email, :body
  validates_length_of :body, :minimum => 5
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i 
  before_create :validate_presence_of_all_fields
  
  def validate_presence_of_all_fields
    if to_whom == "request"
      @return = true
      if organization_name.nil?
        errors.add(:organization_name, "must not be blank")
        @return = false
      end
      if country.nil?
        errors.add(:country, "must not be blank")
        @return = false
      end
      if main_contact.nil?
          errors.add(:main_contact, "must not be blank")
          @return = false
      end
      if position_of_contact.nil?
          errors.add(:position_of_contact, "must not be blank")
          @return = false
      end
      if contact_email.nil?
          errors.add(:contact_email, "must not be blank")
          @return = false
      end
      return @return
    end
  end
  
end