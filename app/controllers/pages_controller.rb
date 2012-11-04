class PagesController < ApplicationController
  include ActionView::Helpers::TextHelper
  def home
    # getting all showable feedbacks, reviews, orgs
    @feedbacks = Feedback.where(:show => true)
    @reviews = Review.where(:show => true)
    @organizations = Organization.where(:show => true)
    
    # selecting reviews to be shown on home page
    if !(@reviews.nil?)
    @show_reviews_all = @reviews.sort_by(&:created_at).reverse
    @show_reviews = @show_reviews_all[0..2]
    end
    
    # selecting organizations to be shown on home page
    if !(@organizations.nil?)
    @show_organizations = @organizations.shuffle
    @show_organizations = @show_organizations[0..1]
    end
    
    # selecting feedbacks to be shown on home page
    if !(@feedbacks.nil?)
    @show_feedbacks_all = @feedbacks.shuffle
    @show_feedbacks = @show_feedbacks_all[0..2]
    end
    
    # new feedback for possible popup-feedback form
    @feedback = Feedback.new
  end
  
  # testing page for development to see how new things work/look
  def test
  end
  
  
  # page asking a user to enable their javascript (please)
  def enable_js 
  end
    
	  # about us page
	  def about
    end
    
    # terms and conditions page
    def terms
    end
    
    # privacy policy page
    def privacy
    end
    
    # FAQ page
    def faq
    end

  
end
