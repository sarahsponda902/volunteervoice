class Contact < ActiveRecord::Base
  validates_presence_of :email, :body, :unless => lambda {self.is_request.present?}
  validates_length_of :body, :minimum => 5, :unless => lambda {self.is_request.present?}
  validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i, :unless => lambda {self.is_request.present?}
end