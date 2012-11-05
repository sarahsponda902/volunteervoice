# == Schema Information
#
# Table name: contacts
#
#  id                      :integer          not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  name                    :string(255)
#  email                   :string(255)
#  body                    :text
#  to_whom                 :string(255)
#  subject                 :string(255)
#  user_id                 :integer
#  organization_account_id :integer
#  organization_name       :string(255)
#  country                 :string(255)
#  organization_url        :string(255)
#  has_profile             :string(255)
#  main_contact            :string(255)
#  position_of_contact     :string(255)
#  contact_email           :string(255)
#  is_request              :boolean
#

class Contact < ActiveRecord::Base
  
  # callbacks
  # NOTE: org account requests are not validated
  validates_presence_of :email, :body
  validates_length_of :body, :minimum => 5
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
end
