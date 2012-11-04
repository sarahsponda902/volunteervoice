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

class ProgramSubject < ActiveRecord::Base
  unloadable
  belongs_to :program
end
