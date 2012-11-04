# == Schema Information
#
# Table name: organization_accounts
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  position               :string(255)
#  type_of_company        :string(255)
#  nonprofit              :boolean
#  username               :string(255)
#  notify                 :boolean
#  country                :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  invitation_token       :string(60)
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  organization_id        :integer
#  organization_name      :string(255)
#  admin_pass             :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  email_confirmation     :string(255)
#

require 'test_helper'

class OrganizationAccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
