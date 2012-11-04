class FlagsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :authenticate_user!
  before_filter :check_for_admin, :only => [:index, :show]

  # GET /flags
  # GET /flags.json
  def index
    @flags = Flag.all.sort_by(&:created_at).reverse

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @flags }
    end
  end

  # GET /flags/1
  # GET /flags/1.json
  # Admin only for further details on the flag
  def show
    @flag = Flag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flag }
    end
  end

  #Thank you page user is directed to after flagging a review
  def thank_you
  end

  # POST /flags
  # POST /flags.json
  def create
    @flag = Flag.new(params[:flag])

    # textilize the body (message/reasons) of the flag
    @flag.body = RedCloth.new( ActionController::Base.helpers.sanitize( @flag.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html


    ### The following if statement will hide the review from the site 
    ###   if the review has no prior flags.
    ### If the review does have prior flags, then it should not be hidden 
    ### *** To prevent a user from repeatedly flagging a review so it disappears
    if @flag.review.flags.empty?
      @review = @flag.review
      @review.flag_show = false   
    end

    respond_to do |format|
      if @flag.save
        format.html { redirect_to "/flags/thank_you" }
        format.json { render json: @flag, status: :created, location: @flag }
      else # This should never happen, only for debugging
        redirect_to root_path
      end
    end
  end

  # DELETE /flags/1
  # DELETE /flags/1.json
  def destroy
    @flag = Flag.find(params[:id])
    @flag.destroy

    respond_to do |format|
      format.html { redirect_to flags_url }
      format.json { head :no_content }
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
