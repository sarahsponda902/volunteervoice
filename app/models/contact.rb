class Contact < ActiveRecord::Base
  validates_presence_of :email, :body, :unless => Proc.new {|contact| contact.to_whom == "request"}
  validates_length_of :body, :minimum => 5, :unless => Proc.new {|contact| contact.to_whom == "request"}
  validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i, :unless => Proc.new {|contact| contact.to_whom == "request"}
