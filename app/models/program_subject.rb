class ProgramSubject < ActiveRecord::Base
  unloadable
  belongs_to :program
end
