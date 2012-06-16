class FlagsController < ApplicationController
  include ActionView::Helpers::TextHelper
  # GET /flags
  # GET /flags.json
  def index
    @flags = Flag.all.reverse

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @flags }
    end
  end

  # GET /flags/1
  # GET /flags/1.json
  def show
    @flag = Flag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flag }
    end
  end

 def thank_you
 end

  # POST /flags
  # POST /flags.json
  def create
    @flag = Flag.new(params[:flag])
    @flag.body = RedCloth.new( ActionController::Base.helpers.sanitize( @flag.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    
    if Review.find(@flag.review_id).flags.empty?
      @review = Review.find(@flag.review_id)
      @review.flag_show = false
      @review.save   
    end
    respond_to do |format|
      if @flag.save
        format.html { redirect_to "/flags/thank_you" }
        format.json { render json: @flag, status: :created, location: @flag }
      else
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
end
