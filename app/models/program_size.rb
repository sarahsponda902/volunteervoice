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

class ProgramSize < ActiveRecord::Base
  unloadable
  belongs_to :program
end
