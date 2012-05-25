class Contact < ActiveRecord::Base
  validates_format_of :email, :with => %r{.+@.+\..+}
  validates_length_of :body, :minimum => 5
end
