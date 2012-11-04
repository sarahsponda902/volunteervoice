# == Schema Information
#
# Table name: feedbacks
#
#  id           :integer          not null, primary key
#  body         :text
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  show         :boolean
#  email        :string(255)
#  truncated100 :text
#  admin_read   :boolean          default(FALSE)
#

require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
