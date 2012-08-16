class SearchesController < ApplicationController
  # GET /searches
  # GET /searches.json
  def index
    if user_signed_in? && current_user.admin?
      @searches = Search.all.sort_by(&:updated_at).reverse

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @searches }
      end
    else
      redirect_to "/searches/search_machine"
    end
  end
  
  def erase_old
    if user_signed_in? && current_user.admin?
      @searches = Search.all
      @searches.each do |search|
        if search.updated_at < 24.hours.ago
          search.destroy
        end
      end
      redirect_to "/searches"
    else
      redirect_to "/searches/search_machine"
    end
  end
  
  def error
    @search = Search.new
    respond_to do |format|
      format.html
    end
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    if Search.exists?(params[:id])
      @search = Search.find(params[:id])
    if @search.keywords.nil?
      keys = ""
    else
      keys = @search.keywords
    end
    if @search.subjects.nil?
      subjects = ""
    else
      subjects = @search.subjects.split("; ")
    end
    if @search.regions.nil?
      regions = ""
    else
      regions = @search.regions.split("; ")
    end
    if @search.sizes.nil?
      sizes = ""
    else
      sizes = @search.sizes.split("; ")
    end
    sort_by = @search.sort_by
    if @search.price_max.nil?
      price_max = 99999
    else
      price_max = @search.price_max
    end
    if @search.price_min.nil?
      price_min = 0
    else
      price_min = @search.price_min
    end
    if (@search.length_min_number.nil? || @search.length_min_param.nil?)
      length_min = 0.weeks.to_f
    else
      length_min = @search.length_min_number.to_i.send(@search.length_min_param).to_f 
    end
    if (@search.length_max_number.nil? || @search.length_max_param.nil?)
      length_max = 2.years.to_f
    else
      length_max = @search.length_max_number.to_i.send(@search.length_max_param).to_f
    end
    
      
    
      @the_search = Program.search do
        keywords keys
        
        with(:program_subjects).any_of(subjects) unless subjects.blank?

        with(:location).any_of(regions) unless regions.blank?
        
        with(:program_sizes).any_of(sizes) unless sizes.blank?

      end
      
      @results = @the_search.results
      
      if (price_max != 99999 || price_min != 0 || length_min != 0.weeks.to_f || length_max != 2.years.to_f )
      
        @cost_length_search = ProgramCostLengthMap.search do
          all_of do
            with(:length).greater_than(length_min)
            with(:length).less_than(length_max)
            with(:cost).greater_than(price_min)
            with(:cost).less_than(price_max)
          end      
        end
        
        @cost_length_results = @cost_length_search.results
        @program_cost_length_results = []
        @cost_length_results.each do |f|
          @program_cost_length_results << Program.find(f.program_id) unless @program_cost_length_results.include?(Program.find(f.program_id))
        end
        @the_results = []
        @program_cost_length_results.each do |f|
          if @results.include?(f)
            @the_results << f
          end
        end
      else
        @the_results = @results
      end
      
    
    
    if @search.showing == "Organizations"
      @organization_results = []
      @the_results.each do |p| 
        @organization_results << Organization.find(p.organization_id) unless @organization_results.include?(Organization.find(p.organization_id))
      end
      @the_results = @organization_results
    end
    
    @the_results.sort_by!(&:overall).reverse! if @search.sort_by == "ratinghigh"
    @the_results.sort_by!(&:overall) if @search.sort_by == "ratinglow"
    @the_results.sort_by!(&:name) if @search.sort_by == "alphabetical"
    @the_results.sort_by!(&:weekly_cost) if @search.sort_by == "pricelow"
    @the_results.sort_by!(&:weekly_cost).reverse! if @search.sort_by == "pricehigh"
        
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @search }
    end
  else
    redirect_to "/searches/error"
  end
  end

  # GET /searches/new
  # GET /searches/new.json
  def new
    @search = Search.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search }
    end
  end
  
  
  def programs_browse
          @search = Search.new
      
              if params[:subject] == "Agriculture"
                @search.subjects = ["Agriculture", "Organic Farming", "Sustainable Development"]
              end
              if params[:subject] == "Animal Care"
                @search.subjects = ["Animal Care", "Animal Rights", "Wildlife Conservation"]
              end
              if params[:subject] == "Caregiving"
                @search.subjects = ["Caregiving", "Elder Care", "Child/Orphan Care", "Disabled Care", "Feed the Homeless"]
              end
              if params[:subject] == "Community Development"
                @search.subjects = ["Community Development", "Youth Development and Outreach"]
              end
              if params[:subject] == "Culture and Community"
                @search.subjects = ["Culture and Community", "Performing Arts", "Fashion", "Music", "Sports & Recreation", "Journalism"]
              end
              if params[:subject] == "Disaster Relief"
                @search.subjects = ["Disaster Relief", "Economics", "Microfinance"]
              end
              if params[:subject] == "Education"
                @search.subjects = ["Teaching English", "Teaching Buddhist Monks", "Teaching Children", "Teaching Computer Literacy"]
              end
              if params[:subject] == "Environmental"
                @search.subjects = ["Environmental", "Ecological Conservation", "Sustainable Development", "Wildlife Conservation", "Habitat Restoration"]
              end
              if params[:subject] == "Health and Medicine"
                @search.subjects = ["Health and Medicine", "HIV/AIDS", "Family Planning", "Nutrition", "Veterinary Medicine", "Clinical Work", "Dental Work", "Medical Research", "Health Education", "Public Health", "Hospital Caregiving"]
              end
              if params[:subject] == "Human Rights"
                @search.subjects = ["Human Rights", "Women's Initiatives"]
              end
              if params[:subject] == "Recreation"
                @search.subjects = ["Recreation", "Adventure Travel"]
              end
              if params[:subject] == "Scientific Research"
                @search.subjects = ["Scientific Research", "Archaeology", "Environmental Biology"]
              end
              if params[:subject] == "Technology"
                @search.subjects = ["Technology", "Teaching Computer Literacy", "Media, Marketing, and Graphic Design"]
              end
              @search.subjects = @search.subjects.join("; ") unless (@search.subjects.class.name == "String" || @search.subjects.nil?)
              
              respond_to do |format|
                if @search.save
                  format.html { redirect_to @search, notice: 'Search was successfully created.' }
                  format.json { render json: @search, status: :created, location: @search }
                else
                  format.html { render action: "new" }
                  format.json { render json: @search.errors, status: :unprocessable_entity }
                end
              end
  end
  
   def search_machine
      @search = Search.new
       @locations = [] 
       Program.all.each do |f| 
       @locations << f.location unless @locations.include?(f.location) 
       end 
    end


    def places
      @programs = Program.all  
      @countries_with_programs = []
      @programs.each do |f|
        @countries_with_programs << f.location unless @countries_with_programs.include?(f.location)
      end
      
         @nums = Array.new
    	 @progNums = Array.new
         @countries_with_programs.each do |f|
    	 @progNums << Program.where(:location => f).count unless f == ""
         @nums << ALLCOUNTRIES.index(f) unless (ALLCOUNTRIES.index(f).nil?)
         end 
      
      
          @americas = Hash.new
          THEREGIONS[10].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@americas[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[11].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@americas[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[12].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@americas[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[13].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@americas[f] = THECOUNTRIES[f]
         	 end 
          end 



          @europe = Hash.new 
          THEREGIONS[6].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@europe[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[7].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@europe[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[8].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@europe[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[9].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@europe[f] = THECOUNTRIES[f]
         	 end 
          end 




          @africa = Hash.new 
          THEREGIONS[1].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@africa[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[2].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@africa[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[3].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@africa[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[4].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@africa[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[5].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@africa[f] = THECOUNTRIES[f]
         	 end 
          end 




          @asia = Hash.new 
          THEREGIONS[14].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@asia[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[15].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@asia[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[16].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@asia[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[17].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@asia[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[18].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@asia[f] = THECOUNTRIES[f]
         	 end 
          end 




          @oceania = Hash.new 
          THEREGIONS[19].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@oceania[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[20].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@oceania[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[21].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@oceania[f] = THECOUNTRIES[f]
         	 end 
          end 
          THEREGIONS[22].each do |f|
         	 if !(Program.where(:location => f).empty?) 
         		@oceania[f] = THECOUNTRIES[f]
         	 end 
          end 



          @americas = @americas.sort_by { |country| country[1] } 
          @europe = @europe.sort_by { |country| country[1] } 
          @africa = @africa.sort_by { |country| country[1] } 
          @asia = @asia.sort_by { |country| country[1] } 
          @oceania = @oceania.sort_by { |country| country[1] } 
      
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @programs }
      end

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
  
  
  

  # POST /searches
  # POST /searches.json
  def create
    
    
    
    
    @search = Search.new(params[:search])
    if !(params[:subject].nil?)
      @search.subjects = [] << SUBJECTSHASH[params[:subject]]
    end
    if !(params[:location].nil?)
      @search.regions = [] << params[:location]
    end
     
    
    @search.regions = @search.regions.join("; ") unless (@search.regions.class.name == "String" || @search.regions.nil?)
    @search.subjects = @search.subjects.join("; ") unless (@search.subjects.class.name == "String" || @search.subjects.nil?)
    @search.sizes = @search.sizes.join("; ") unless (@search.sizes.class.name == "String" || @search.sizes.nil?)

    if @search.length_min_param.nil?
      @search.length_min_param = "weeks"
    end
    if @search.length_max_param.nil?
      @search.length_max_param = "years"
    end
    if @search.length_min_number.nil?
      @search.length_min_number = 0
    end
    if @search.length_max_number.nil?
      @search.length_max_number = 2
    end
    if @search.price_min.nil?
      @search.price_min = 0
    end
    if @search.price_max.nil?
      @search.price_max = 99999
    end
    
    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render json: @search, status: :created, location: @search }
      else
        format.html { render action: "new" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /searches/1
  # PUT /searches/1.json
  def update
    @search = Search.find(params[:id])
     params[:search][:regions] = params[:search][:regions].join("; ") unless (params[:search][:regions].class.name == "String" || params[:search][:regions].nil?)
     params[:search][:subjects] = params[:search][:subjects].join("; ") unless (params[:search][:subjects].class.name == "String" || params[:search][:subjects].nil?)
     params[:search][:sizes] = params[:search][:sizes].join("; ") unless (params[:search][:sizes].class.name == "String" || params[:search][:sizes].nil?)
    
      respond_to do |format|
      if @search.update_attributes(params[:search])
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :no_content }
    end
  end
end
