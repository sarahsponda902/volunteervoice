# == Schema Information
#
# Table name: program_sizes
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  program_id      :integer
#  size            :string(255)
#  organization_id :integer
#

require 'test_helper'

class ProgramSizeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
