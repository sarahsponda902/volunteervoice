class FlagsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :authenticate_user!
  before_filter :check_for_admin, :only => [:index, :show]
  respond_to :html, :json
  
  # GET /flags
  # GET /flags.json
  def index
    @flags = Flag.all.sort_by(&:created_at).reverse
    respond_with(@flags)
  end

  # GET /flags/1
  # GET /flags/1.json
  # Admin only for further details on the flag
  def show
    @flag = Flag.find(params[:id])
    respond_with(@flag)
  end

  #Thank you page user is directed to after flagging a review
  def thank_you
  end

  # POST /flags
  # POST /flags.json
  def create
    @flag = Flag.new(params[:flag])
    @flag.body = RedCloth.new( ActionController::Base.helpers.sanitize( @flag.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @flag.save
    redirect_to "/flags/thank_you"
  end

  # DELETE /flags/1
  # DELETE /flags/1.json
  def destroy
    @flag = Flag.find(params[:id])
    @flag.destroy
    respond_with(@flag)
  end

  private
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
end
