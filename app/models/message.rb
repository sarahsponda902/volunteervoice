class Message < ActiveRecord::Base
  attr_accessible :recipient_id, :sender_id, :subject, :body
  belongs_to :user
  is_private_message
  
  before_save :parse_body
  
  
  def parse_body
    self.body = RedCloth.new(body).to_html
  end
  
  # The :to accessor is used by the scaffolding,
  # uncomment it if using it or you can remove it if not
  #attr_accessor :to
  
end