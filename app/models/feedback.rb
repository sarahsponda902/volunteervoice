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
  
  #associations
  belongs_to :user
  
  #attributes
  attr_accessible :body, :user_id, :show, :email
  
  #callbacks
  validates_length_of :body, :minimum => 5
  profanity_filter :body
  before_save :validates_email
  
  ### callback methods ###
  # errors if feedback has no email and user is not logged in
  def validates_email
    unless self.user_id || self.email
      errors.add(:email, "must not be blank")
      return false
    end
  end

  def self.untextilized(textile)
    return Nokogiri::HTML.fragment(textile).text
  end

  # for textilizing plain text from a textarea box
  # so that newlines and formatting are preserved
  def self.textilized(text)
    return RedCloth.new( ActionController::Base.helpers.sanitize( text ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
  end 
end
