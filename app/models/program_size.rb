class ProgramSize < ActiveRecord::Base
  unloadable
  belongs_to :program
end
