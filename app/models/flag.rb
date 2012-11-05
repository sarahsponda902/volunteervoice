# == Schema Information
#
# Table name: flags
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  body       :text
#  poster_id  :integer
#  flagger_id :integer
#  review_id  :integer
#  category   :string(255)
#  admin_read :boolean          default(FALSE)
#

class Flag < ActiveRecord::Base
  # attributes
  attr_accessible :review_id, :poster_id, :flagger_id, :body, :category
  
  # associations
  belongs_to :review
end
