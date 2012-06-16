class Flag < ActiveRecord::Base
  attr_accessible :review_id, :poster_id, :flagger_id, :body, :category
  belongs_to :review
end
