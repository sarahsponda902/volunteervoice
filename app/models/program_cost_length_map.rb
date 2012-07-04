class ProgramCostLengthMap < ActiveRecord::Base
  unloadable
  belongs_to :program
  searchable do 
    location :coordinates
  end
  
  def coordinates
      Sunspot::Util::Coordinates.new(self.length, self.cost)
  end
end
