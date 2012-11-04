# == Schema Information
#
# Table name: flags
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  body       :text
#  poster_id  :integer
#  flagger_id :integer
#  review_id  :integer
#  category   :string(255)
#  admin_read :boolean          default(FALSE)
#

require 'test_helper'

class FlagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
