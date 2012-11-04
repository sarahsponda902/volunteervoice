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

class ProgramCostLengthMap < ActiveRecord::Base
  unloadable
  belongs_to :program
  searchable do 
    integer :length
    integer :cost
  end

end
