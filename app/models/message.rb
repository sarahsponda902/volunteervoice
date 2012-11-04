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
  attr_accessible :recipient_id, :sender_id, :subject, :body
  belongs_to :user
  is_private_message
  validates_not_profane :body, :subject

  
  # The :to accessor is used by the scaffolding,
  # uncomment it if using it or you can remove it if not
  #attr_accessor :to

  
end
