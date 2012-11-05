# == Schema Information
#
# Table name: program_cost_length_maps
#
#  id              :integer          not null, primary key
#  program_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer
#  length_name     :string(255)
#  length_number   :integer
#  cost            :float
#  length          :float
#

## a cost_length_map is an object that hold the cost of a program and it's associated length of time
class ProgramCostLengthMap < ActiveRecord::Base
  unloadable
  
  #associations
  belongs_to :program
  
  #sunspot search block
  searchable do 
    integer :length
    integer :cost
  end

end
