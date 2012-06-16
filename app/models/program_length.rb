class ProgramLength < ActiveRecord::Base
  unloadable
  belongs_to :program
end
