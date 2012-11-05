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

# a program_size is an object that holds a program's group size
# a program can have multiple program_sizes
class ProgramSize < ActiveRecord::Base
  unloadable
  
  # associations
  belongs_to :program
end
