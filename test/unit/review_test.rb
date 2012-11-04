# == Schema Information
#
# Table name: reviews
#
#  id                :integer          not null, primary key
#  body              :text
#  program_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  show              :boolean
#  organization_id   :integer
#  before            :boolean
#  terms             :boolean
#  preparation       :decimal(, )
#  support           :decimal(, )
#  impact            :decimal(, )
#  structure         :decimal(, )
#  overall           :decimal(, )
#  time_frame        :string(255)
#  photo             :string(255)
#  organization_name :string(255)
#  photo2            :string(255)
#  photo3            :string(255)
#  photo4            :string(255)
#  photo5            :string(255)
#  photo6            :string(255)
#  photo7            :string(255)
#  photo8            :string(255)
#  photo9            :string(255)
#  photo10           :string(255)
#  truncated100      :text
#  truncated200      :text
#  flag_show         :boolean
#  admin_read        :boolean          default(FALSE)
#

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
