class ProgramCostLengthMap < ActiveRecord::Base
  unloadable
  belongs_to :program
  searchable do 
    integer :length
    integer :cost
  end

end
