class Contact < ActiveRecord::Base
  validates_presence_of :email, :body
  validates_length_of :body, :minimum => 5
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
end