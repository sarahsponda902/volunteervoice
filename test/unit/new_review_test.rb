# == Schema Information
#
# Table name: new_reviews
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  body         :text
#  user_id      :integer
#  before       :boolean
#  terms        :boolean
#  preparation  :decimal(, )
#  support      :decimal(, )
#  impact       :decimal(, )
#  structure    :decimal(, )
#  overall      :decimal(, )
#  organization :string(255)
#  program      :string(255)
#  time_frame   :string(255)
#  photo        :string(255)
#  truncated100 :text
#  photo2       :string(255)
#  photo3       :string(255)
#  photo4       :string(255)
#  photo5       :string(255)
#  photo6       :string(255)
#  photo7       :string(255)
#  photo8       :string(255)
#  photo9       :string(255)
#  photo10      :string(255)
#  admin_read   :boolean          default(FALSE)
#

require 'test_helper'

class NewReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
