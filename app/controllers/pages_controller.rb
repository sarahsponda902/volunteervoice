class PagesController < ApplicationController
  include ActionView::Helpers::TextHelper
  def home
    @feedbacks = Feedback.where(:show => true)
    @reviews = Review.where(:show => true)
    @organizations = Organization.where(:show => true)
    if !(@reviews.nil?)
    @show_reviews_all = @reviews.sort_by(&:created_at).reverse
    @show_reviews = @show_reviews_all[0..2]
    end
    if !(@organizations.nil?)
    @show_organizations_all = @organizations.sort_by(&:overall)
    @show_organizations = @show_organizations_all[0..1]
    end
    if !(@feedbacks.nil?)
    @show_feedbacks_all = @feedbacks.shuffle
    @show_feedbacks = @show_feedbacks_all[0..2]
    end
    @feedback = Feedback.new
  end
  
  def program_listing
  	@programs = Program.all
  end
  
  def test
  end
  
  def enable_js 
  end
    
	  
	  def about
    end
    
    def terms
    end
    
    def privacy
    end
    
    def faq
    end

  
end
