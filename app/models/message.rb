# == Schema Information
#
# Table name: messages
#
#  id                :integer          not null, primary key
#  subject           :string(255)
#  sender_id         :integer
#  recipient_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  recipient_deleted :boolean          default(FALSE)
#  read_at           :datetime
#  sender_deleted    :boolean
#  body              :text
#

class Message < ActiveRecord::Base
  # associations
  belongs_to :user
  
  # attributes
  attr_accessible :recipient_id, :sender_id, :subject, :body
  
  # callbacks
  validates_not_profane :body, :subject

  # for private_messages plugin
  is_private_message

  
end
