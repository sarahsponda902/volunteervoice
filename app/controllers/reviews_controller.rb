class ReviewsController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_filter :authenticate_user!, :only => [:create, :new, :edit, :destroy, :update]
  before_filter :check_for_admin, :only => [:index, :changeShow, :changeFlagShow]
  before_filter :set_review_and_authenticate_correct_user, :only => [:update, :destroy]
  respond_to :html, :json
  
  # page showing all reviews (sorted) published on vvi
  # can access this page by clicking "# voices heard" on homepage
  def show_all
    @sort_by = params[:sort_by]
    @reviews = Review.order(params[:sort_by])
    @flag = Flag.new
  end

  # User only create a new review
  def create
    @review = Review.new(params[:review])
    @review.body = textilized( @review.body )
    @review.organization_id = Organization.where(:name => @review.organization_name).first.id

    # @user_review_progs used for checking if a user has reviewed a program before
    @user_review_progs = current_user.reviews.map{|rev| rev.program_id}

    respond_with(@review) do
      if !(@user_review_progs.include?(@review.program_id))
        if @review.save
          Organization.find(@review.organization_id).update_attributes({:reviewed_at => Time.now})
        else
          @review.body = untextilized(@review.body)
        end
      else
        @review_id = Review.where(:program_id => @review.program_id, :user_id => current_user.id).first.id
        flash[:notice] = flash[:notice].to_a.concat(["You can only review a program once. Please add on to your review instead!"])
        redirect_to(edit_review_path(:id => @review_id, :edit_review_body => untextilized(@review.body)))
      end
    end
  end

  # thank you page after a user reviews a program
  def thank_you_review
  end


  # Admin only index page
  def index
    @reviews = Review.all.reverse
    respond_with(@reviews)
  end

  # GET /reviews/1
  def show
    @review = Review.find(params[:id])
    respond_with(@review)
  end


  # User only write-a-review page
  def new
    @review = Review.new
    respond_with(@review)
  end


  # edit review page (user only)
  def edit
    @review = Review.find(params[:id])
    respond_with(@review)
  end


  def update
    @review = Review.find(params[:id])
    params[:review][:body] = "Update #{Time.now.to_date.strftime("%m/%e/%Y").gsub(/^0/, '')}: \n"+textilized(params[:review][:body]) + "<br />"+@review.body
    respond_with(@review) do
      if @review.update_attributes(params[:review])
        flash[:notice] = "Review Submitted"
        redirect_to "/users/profile"
      else
        params[:review][:body] = @review.body
      end
    end
  end


  # Admin & User only destroy method
  def destroy
    @review.destroy
    respond_with(@review) do
      unless current_user.admin?
        redirect_to "/users/profile"
      end
    end
  end


  # Admin only 
  # change whether the review can be displayed on the home page or not
  def changeShow
    @review = Review.find(params[:id])
    @review.update_params({:show => !@review.show})
    redirect_to reviews_path
  end

  # called by Admin or if a review is flagged for the first time
  # change whether the review can be displayed at all 
  def changeFlagShow
    @review = Review.find(params[:id])
    @review.update_params({:flag_show => !@review.flag_show})
    redirect_to flags_path
  end

  private
  ## check_for_admin called by before_filter
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
  
  def set_review_and_authenticate_correct_user
    @review = Review.find(params[:id])
    unless (@review.user_id == current_user.id?) || current_user.admin?
      redirect_to root_path
    end
  end

end
