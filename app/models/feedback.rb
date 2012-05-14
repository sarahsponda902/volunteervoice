class Feedback < ActiveRecord::Base
  belongs_to :page
  attr_accessible :body, :user_id, :show, :email
end
