class Contact < ActiveRecord::Base
  validates_presence_of :name, :email, :subject, :body
  validates_format_of :email, :with => %r{.+@.+\..+}
end
