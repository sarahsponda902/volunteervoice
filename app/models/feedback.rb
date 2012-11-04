# == Schema Information
#
# Table name: feedbacks
#
#  id           :integer          not null, primary key
#  body         :text
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  show         :boolean
#  email        :string(255)
#  truncated100 :text
#  admin_read   :boolean          default(FALSE)
#

class Feedback < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :user_id, :show, :email
  validates_length_of :body, :minimum => 5
  validates_not_profane :body
  before_save :validates_email
  
  def validates_email
    if !self.user_id
      if !self.email
        errors.add(:email, "must not be blank")
        return false
      end
    end
  end
  


  
end
