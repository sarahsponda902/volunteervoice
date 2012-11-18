class FeedbacksController < ApplicationController
  before_filter :check_for_admin, :except => [:new, :create, :thank_you]
  respond_to :html, :json
  include ActionView::Helpers::TextHelper
  include ApplicationHelper

  # GET /feedbacks
  # GET /feedbacks.json

  # Admin only index page
  def index
    @feedbacks = Feedback.all.sort_by(&:created_at).reverse
    respond_with @feedbacks 
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json

  # Admin only show feedback page
  # (note - there is no link to actually get to this page, 
  #    but keeping it for possible future use)
  def show
    @feedback = Feedback.find(params[:id])
    respond_with @feedback
  end



  # GET /feedbacks/new
  # GET /feedbacks/new.json
  # new feedback page
  #   note - only gets called when there is an error from popup
  def new
    @feedback = Feedback.new
    respond_with @feedback
  end



  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(params[:feedback])
    respond_with(@feedback) do
      redirect_to "/feedbacks/thank_you" if @feedback.save
    end
  end


  # Thank you page
  # Directed to thank you page after creating a feedback
  def thank_you
  end


  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  # Admin only destroy feedback
  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy
    redirect_to feedbacks_path
  end

  # method called by admin on feedback index page
  # to change whether the feedback is shown on the home page
  # Admin only
  def changeShow
    @feedback = Feedback.find(params[:id])
    @feedback.show = !@feedback.show
    @feedback.save
    redirect_to feedbacks_path
  end

  private

  ## check_for_admin called by before_filter
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end

end
