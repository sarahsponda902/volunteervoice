class MessagesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :authenticate_user!
  before_filter :check_for_admin, :only => [:index]
  respond_to :html, :json
  
  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new
    @message.recipient_id = params[:recipient_id]
    respond_with(@message)
  end

  # Admin only index page
  # Shows only the sender ID and recipient ID on the page, no message content
  def index
    @messages = Message.find(:all, :order => "created_at").reverse
    respond_with(@messages)
  end


  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])
    @message.body = RedCloth.new( ActionController::Base.helpers.sanitize( @message.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    if @message.save
      flash[:notice] = "Message was sent"
      @recipient = User.find(@message.recipient_id)
      @recipient.unread_messages = @recipient.unread_messages + 1
      @recipient.save 
    else
      @message.body = Nokogiri::HTML.fragment(@message.body).text
    end
    respond_with(@message)
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  # only called if both the sender and recipient mark the message as deleted
  def destroy
    @message = Message.find(params[:id])
    if user_signed_in? && ((current_user.admin?) || (current_user.id == @message.sender_id) || (current_user.id == @message.recipient_id))
      @message.destroy
    end
    respond_with(@message) do
      redirect_to "/users/profile"
    end

  end


  # mark the message as deleted for the sender
  # (the message will no longer appear in the sender's 'sent messages')
  def mark_sent_deleted
    @message = Message.find(params[:id])
    if (user_signed_in?) && ((current_user.admin?) || (current_user.id == @message.sender_id))
      @message.sender_deleted = true
      @message.save
      redirect_to "/users/profile/sent_deleted"
    else # if not authorized to mark sent deleted
      redirect_to "/users/profile"
    end
  end


  # mark the message as deleted for the recipient
  # (the message will no longer appear in the recipient's inbox)
  def mark_deleted
    @message = Message.find(params[:id])
    if (user_signed_in?) && ((current_user.admin?) || (current_user.id == @message.recipient_id))
      @message.recipient_deleted = true
      @message.save
      redirect_to "/users/profile/message_deleted"
    else #if not authorized to mark recipient deleted
      redirect_to "/users/profile"
    end

  end

  private
  # called by before_filter
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
end
