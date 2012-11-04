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

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
