# == Schema Information
#
# Table name: messages
#
#  id                :integer          not null, primary key
#  subject           :string(255)
#  sender_id         :integer
#  recipient_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  recipient_deleted :boolean          default(FALSE)
#  read_at           :datetime
#  sender_deleted    :boolean
#  body              :text
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
