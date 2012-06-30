class ProgramCostLengthMap < ActiveRecord::Base
  unloadable
  belongs_to :program
  geocoded_by :cost_length_map, :latitude => :length, :longitude => :cost
end
