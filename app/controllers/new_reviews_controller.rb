class NewReviewsController < ApplicationController
  ########################################################################################
  ## NEW_REVIEWS are reviews for organizations that have not been added to our database ##
  ########################################################################################

  include ActionView::Helpers::TextHelper
  before_filter :check_for_admin, :only => [:index, :show, :destroy]

  # GET /new_reviews
  # GET /new_reviews.json
  def index
    @new_reviews = NewReview.all.sort_by(&:created_at).reverse
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @new_reviews }
    end
  end

  # GET /new_reviews/1
  # GET /new_reviews/1.json
  def show
    @new_review = NewReview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @new_review }
    end
  end

  # GET /new_reviews/new
  # GET /new_reviews/new.json
  def new
    @new_review = NewReview.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @new_review }
    end
  end

  ## thank you page called after a user creates a new 'New Review'
  def thank_you_new_review
  end

  # POST /new_reviews
  # POST /new_reviews.json
  def create
    @new_review = NewReview.new(params[:new_review])
    @new_review.body = RedCloth.new( ActionController::Base.helpers.sanitize( @new_review.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html

    respond_to do |format|
      if @new_review.save
        format.html { redirect_to "/new_reviews/thank_you_new_review" }
        format.json { render json: @new_review, status: :created, location: @new_review }
      else
        @new_review.body = Nokogiri::HTML.fragment(@new_review.body).text
        flash[:notice] = flash[:notice].to_a.concat @new_review.errors.full_messages
        format.html { render action: "new" }
        format.json { render json: @new_review.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /new_reviews/1
  # DELETE /new_reviews/1.json
  def destroy
    @new_review = NewReview.find(params[:id])
    @new_review.destroy

    respond_to do |format|
      format.html { redirect_to new_reviews_url }
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
