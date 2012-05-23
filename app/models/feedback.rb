class Feedback < ActiveRecord::Base
  belongs_to :page
  attr_accessible :body, :user_id, :show, :email
  validates_length_of :body, :minimum => 5
  before_save validates_email
  
  def validates_email
    if !self.user_id
      if !self.email
        return false
      end
    end
  end
  
end
