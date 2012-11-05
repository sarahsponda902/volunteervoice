# == Schema Information
#
# Table name: program_subjects
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  program_id      :integer
#  subject         :string(255)
#  organization_id :integer
#

# a program_subject is an object that holds a program's subject tag
# a program can have multiple program_subjects (limited to 4)
class ProgramSubject < ActiveRecord::Base
  unloadable
  belongs_to :program
end
