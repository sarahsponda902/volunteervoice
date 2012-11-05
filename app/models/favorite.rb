# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  program_id :integer
#

class Favorite < ActiveRecord::Base
  
  # associations
  belongs_to :user
  
end
