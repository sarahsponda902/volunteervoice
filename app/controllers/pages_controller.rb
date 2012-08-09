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
  
  def thank_you_request
  end
    
    def blogs
      @interesting = BlogPost.where(:is_our_blog => false).sort_by{|e| e[:published_at]}.reverse
      
      @our_blog = BlogPost.where(:is_our_blog => true).sort_by{|e| e[:published_at]}.reverse
  
      @boolA = true
      @boolV = true
    end
    
    def blog_search
      @search_words = params[:search] 
      
      @interesting_search = Sunspot.search(BlogPost) do
        keywords params[:search]
        with :is_our_blog, false
      end
      @our_blog_search = Sunspot.search(BlogPost) do
        keywords params[:search]
        with :is_our_blog, true 
      end
      @interesting_tags_search = Sunspot.search(BlogTag) do
        with :tag, params[:search].gsub(/[^0-9A-Za-z]/, "").split(" ")
        with :is_our_blog, false
      end
      @our_blog_tags_search = Sunspot.search(BlogTag) do
        with :tag, params[:search].gsub(/[^0-9A-Za-z]/, "").split(" ")
        with :is_our_blog, true
      end
      @interesting = []
      @our_blog = []
      @interesting_tags_search.results.each do |f|
        @interesting << BlogPost.find(f.blog_post_id)
      end
      @interesting_search.results.each do |f|
        @interesting << f unless @interesting.include?(f)
      end
      @interesting = @interesting.sort_by{|e| e[:published_at]}.reverse
      
      @our_blog_tags_search.results.each do |f|
        @our_blog << BlogPost.find(f.blog_post_id)
      end
      @our_blog_search.results.each do |f|
        @our_blog << f unless @our_blog.include?(f)
      end
      @our_blog = @our_blog.sort_by{|e| e[:published_at]}.reverse
      @results = @interesting + @our_blog
      @results = @results.sort_by{|e| e[:published_at]}.reverse
    end
	  
	  def about
    end
    
    def terms
    end
    
    def privacy
    end
    
    def faq
    end

    
    def search_machine
      @search = Search.new
      
    end

    
    def program_browse
      @organic_farming = ProgramSubject.where(:subject => "Organic Farming")
      @sustainable_development = ProgramSubject.where(:subject => "Sustainable Development")
      @animal_rights = ProgramSubject.where(:subject => "Animal Rights")
      @wildlife_conservation = ProgramSubject.where(:subject => "Wildlife Conservation")
      @elder_care = ProgramSubject.where(:subject => "Elder Care")
      @child_orphan_care = ProgramSubject.where(:subject => "Child/Orphan Care")
      @disabled_care = ProgramSubject.where(:subject => "Disabled Care")
      @feed_the_homeless = ProgramSubject.where(:subject => "Feed the Homeless")
      @youth_development_and_outreach = ProgramSubject.where(:subject => "Youth Development and Outreach")
      @performing_arts = ProgramSubject.where(:subject => "Performing Arts")
      @fashion = ProgramSubject.where(:subject => "Fashion")
      @music = ProgramSubject.where(:subject => "Music")
      @sports_and_recreation = ProgramSubject.where(:subject => "Sports & Recreation")
      @journalism = ProgramSubject.where(:subject => "Journalism")
      @economics = ProgramSubject.where(:subject => "Economics")
      @microfinance = ProgramSubject.where(:subject => "Microfinance")
      @teaching_english = ProgramSubject.where(:subject => "Teaching English")
      @teaching_buddhist_monks = ProgramSubject.where(:subject => "Teaching Buddhist Monks")
      @teaching_children = ProgramSubject.where(:subject => "Teaching Children")
      @teaching_computer_literacy = ProgramSubject.where(:subject => "Teaching Computer Literacy")
      @ecological_conservation = ProgramSubject.where(:subject => "Ecological Conservation")
      @habitat_restoration = ProgramSubject.where(:subject => "Habitat Resotration")
      @hiv_aids = ProgramSubject.where(:subject => "HIV/AIDS")
      @nutrition = ProgramSubject.where(:subject => "Nutrition")
      @family_planning = ProgramSubject.where(:subject => "Family Planning")
      @veterinary_medicine = ProgramSubject.where(:subject => "Veterinary Medicine")
      @clinical_work = ProgramSubject.where(:subject => "Clinical Work")
      @dental_work = ProgramSubject.where(:subject => "Dental Work")
      @medical_research = ProgramSubject.where(:subject => "Medical Research")
      @health_education = ProgramSubject.where(:subject => "Health Education")
      @public_health = ProgramSubject.where(:subject => "Public Health")
      @hospital_care_giving = ProgramSubject.where(:subject => "Hospital Care-giving")
      @womens_initiatives = ProgramSubject.where(:subject => "Women's Initiatives")
      @adventure_travel = ProgramSubject.where(:subject => "Adventure Travel")
      @archaeology = ProgramSubject.where(:subject => "Archaeology")
      @environmental_biology = ProgramSubject.where(:subject => "Environmental Biology")
      @media_marketing_and_graphic_design = ProgramSubject.where(:subject => "Media, Marketing, and Graphic Design")
      
      @agriculture = ProgramSubject.where(:subject => "Agriculture") + @organic_farming + @sustainable_development
      @animal_care = ProgramSubject.where(:subject => "Animal Care") + @animal_rights + @wildlife_conservation
      @caregiving = ProgramSubject.where(:subject => "Caregiving") + @elder_care + @child_orphan_care + @disabled_care + @feed_the_homeless
      @community_development = ProgramSubject.where(:subject => "Community Development") + @youth_development_and_outreach
      @construction = ProgramSubject.where(:subject => "Construction")
      @culture_and_community = ProgramSubject.where(:subject => "Culture & Community") + @performing_arts + @fashion + @music + @sports_and_recreation + @journalism
      @disaster_relief = ProgramSubject.where(:subject => "Disaster Relief") + @economics + @microfinance
      @education = ProgramSubject.where(:subject => "Education") + @teaching_english + @teaching_buddhist_monks + @teaching_children + @teaching_computer_literacy
      @engineering_and_infrastructure = ProgramSubject.where(:subject => "Engineering and Infrastructure")
      @environmental = ProgramSubject.where(:subject => "Environmental") + @ecological_conservation + @sustainable_development + @wildlife_conservation + @habitat_restoration
      @health_and_medicine = ProgramSubject.where(:subject => "Health and Medicine") + @hiv_aids + @nutrition + @family_planning + @veterinary_medicine + @clinical_work + @dental_work + @medical_research + @health_education + @public_health + @hospital_care_giving
      @human_rights = ProgramSubject.where(:subject => "Human Rights") + @womens_initiatives
      @international_work_camp = ProgramSubject.where(:subject => "International Work Camp")
      @recreation = ProgramSubject.where(:subject => "Recreation") + @adventure_travel
      @scientific_research = ProgramSubject.where(:subject => "Scientific Research") + @archaeology + @environmental_biology
      @technology = ProgramSubject.where(:subject => "Technology") + @teaching_computer_literacy + @media_marketing_and_graphic_design
      
    end

    
    def thank_you
    end
    
    def thank_you_review
    end
    
    def thank_you_new_review
    end
  
end
