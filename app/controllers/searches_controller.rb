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
      redirect_to "/pages/search_machine"
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
      redirect_to "/pages/search_machine"
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
        @real_results = @results
        @results = []
        @program_cost_length_results.each do |f|
          if @real_results.include?(f)
            @results << f
          end
        end
      end
      
    
    
    if @search.showing == "Organizations"
      @organization_results = []
      @results.each do |p| 
        @organization_results << Organization.find(p.organization_id) unless @organization_results.include?(Organization.find(p.organization_id))
      end
      @results = @organization_results
    end
    
    @results.sort_by!(&:overall).reverse! if @search.sort_by == "ratinghigh"
    @results.sort_by!(&:overall) if @search.sort_by == "ratinglow"
    @results.sort_by!(&:name) if @search.sort_by == "alphabetical"
    @results.sort_by!(&:weekly_cost) if @search.sort_by == "pricelow"
    @results.sort_by!(&:weekly_cost).reverse! if @search.sort_by == "pricehigh"
        
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

  # POST /searches
  # POST /searches.json
  def create
    @subjects = Hash['Agriculture' => 'Agriculture' , 
    'OrganicFarming' => 'Organic Farming' , 
    'SustainableDevelopment' => 'Sustainable Development' , 
    'AnimalCare' => 'Animal Care' , 
    'AnimalRights' => 'Animal Rights' , 
    'WildlifeConservation' => 'Wildlife Conservation' , 
    'Caregiving' => 'Caregiving' , 
    'ElderCare' =>       'Elder Care' , 
    'Child/OrphanCare' =>       'Child/Orphan Care' , 
    'DisabledCare' =>       'Disabled Care' , 
    'FeedtheHomeless' =>       'Feed the Homeless' , 
    'CommunityDevelopment' =>       'Community Development' , 
    'YouthDevelopmentandOutreach' =>       'Youth Development and Outreach' , 
    'Construction' =>       'Construction' , 
    'CultureandCommunity' =>       'Culture and Community' , 
    'PerformingArts' =>       'Performing Arts' , 
    'Fashion' =>       'Fashion' , 
    'Music' =>       'Music' , 
    'Sports&Recreation' =>       'Sports & Recreation' , 
    'Journalism' =>       'Journalism' , 
    'DisasterRelief' =>       'Disaster Relief' , 
    'Economics' =>       'Economics' , 
    'Microfinance' =>       'Microfinance' , 
    'Education' =>       'Education' , 
    'TeachingEnglish' =>       'Teaching English' , 
    'TeachingBuddhistMonks' =>       'Teaching Buddhist Monks' , 
    'TeachingChildren' =>       'Teaching Children' , 
    'TeachingComputerLiteracy' =>       'Teaching Computer Literacy' , 
    'EngineeringandInfrastructure' =>       'Engineering and Infrastructure' , 
    'Environmental' =>       'Environmental' , 
    'EcologicalConservation' =>       'Ecological Conservation' , 
    'SustainableDevelopment' =>       'Sustainable Development' , 
    'WildlifeConservation' =>       'Wildlife Conservation' , 
    'HabitatRestoration' =>       'Habitat Restoration' , 
    'HealthandMedicine' =>       'Health and Medicine' , 
    'HIV/AIDS' =>       'HIV/AIDS' , 
    'Nutrition' =>       'Nutrition' , 
    'FamilyPlanning' =>       'Family Planning' , 
    'VeterinaryMedicine' =>       'Veterinary Medicine' , 
    'ClinicalWork' =>       'Clinical Work' , 
    'DentalWork' =>       'Dental Work' , 
    'MedicalResearch' =>       'Medical Research' , 
    'HealthEducation' =>       'Health Education' , 
    'PublicHealth' =>       'Public Health' , 
    'HospitalCare-giving' =>       'Hospital Care-giving' , 
    'HumanRights' =>       'Human Rights' , 
    'WomensInitiatives' =>       'Womens Initiatives' , 
    'InternationalWorkCamp' =>       'International Work Camp' , 
    'Recreation' =>       'Recreation' , 
    'AdventureTravel' =>       'Adventure Travel' , 
    'ScientificResearch' =>       'Scientific Research' , 
    'Archaeology' =>       'Archaeology' , 
    'EnvironmentalBiology' =>       'Environmental Biology' , 
    'Technology' =>       'Technology' , 
    'TeachingComputerLiteracy' =>       'Teaching Computer Literacy' , 
    'MediaMarketingandGraphicDesign' =>       'Media Marketing and Graphic Design',]
    
    
    
    @search = Search.new(params[:search])
    if !(params[:subject].nil?)
      @search.subjects = [] << @subjects[params[:subject]]
    end
    if !(params[:location].nil?)
      @search.regions = [] << params[:location]
    end
    if @search.subjects.nil?
      @search.subjects = ["false"]
    end
    if @search.regions.nil?
      @search.regions = ["false"]
    end
    if @search.sizes.nil?
      @search.sizes = ["false"]
    end
    
    if @search.subjects.include?('Agriculture')
      @search.subjects = ['Organic Farming', 'Sustainable Development'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Animal Care')
      @search.subjects = ['Animal Rights', 'Wildlife Conservation'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Caregiving')
      @search.subjects = ['Elder Care', 'Child/Orphan Care', 'Disabled Care', 'Feed the Homeless'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Community Development')
      @search.subjects = ['Youth Development and Outreach'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Culture and Community')
      @search.subjects = ['Performing Arts', 'Fashion', 'Music', 'Sports & Recreation', 'Journalism'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Disaster Relief')
      @search.subjects = ['Economics', 'Microfinance'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Education')
      @search.subjects = ['Teaching Buddhist Monks', 'Teaching Children', 'Teaching Computer Literacy'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Environmental')
      @search.subjects = ['Ecological Conservation', 'Sustainable Development', 'Wildlife Conservation', 'Habitat Restoration'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Health and Medicine')
      @search.subjects = ['HIV/AIDS', 'Family Planning', 'Nutrition', 'Veterinary Medicine', 'Clinical Work', 'Dental Work', 'Medical Research', 'Health Education', 'Public Health', 'Hospital Caregiving'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Human Rights')
      @search.subjects = ['Womens Initiatives'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Recreation')
      @search.subjects = ['Adventure Travel'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Scientific Research')
      @search.subjects = ['Archaeology', 'Environmental Biology'] + (@search.subjects.split("; "))
    end
    if @search.subjects.include?('Technology')
      @search.subjects = ['Teaching Computer Literacy', 'Media Marketing and Graphic Design'] + (@search.subjects.split("; "))
    end
    
    if @search.subjects.include?("false")
      @search.subjects = ['Agriculture', 
        'Organic Farming', 
        'Sustainable Development', 
        'Animal Care', 
        'Animal Rights', 
        'Wildlife Conservation', 
        'Caregiving', 
        'Elder Care', 
        'Child/Orphan Care', 
        'Disabled Care', 
        'Feed the Homeless', 
        'Community Development', 
        'Youth Development and Outreach', 
        'Construction', 
        'Culture and Community', 
        'Performing Arts', 
        'Fashion', 
        'Music', 
        'Sports & Recreation', 
        'Journalism', 
        'Disaster Relief', 
        'Economics', 
        'Microfinance', 
        'Education', 
        'Teaching English', 
        'Teaching Buddhist Monks', 
        'Teaching Children', 
        'Teaching Computer Literacy', 
        'Engineering and Infrastructure', 
        'Environmental', 
        'Ecological Conservation', 
        'Sustainable Development', 
        'Wildlife Conservation', 
        'Habitat Restoration', 
        'Health and Medicine', 
        'HIV/AIDS', 
        'Nutrition', 
        'Family Planning', 
        'Veterinary Medicine', 
        'Clinical Work', 
        'Dental Work', 
        'Medical Research', 
        'Health Education', 
        'Public Health', 
        'Hospital Care-giving', 
        'Human Rights', 
        'Womens Initiatives', 
        'International Work Camp', 
        'Recreation', 
        'Adventure Travel', 
        'Scientific Research', 
        'Archaeology', 
        'Environmental Biology', 
        'Technology', 
        'Teaching Computer Literacy', 
        'Media Marketing and Graphic Design']
    end
    
    if (@search.regions.include?('Americas'))
      @search.regions = ['BM', 
      'CA', 
      'GL', 
      'PM', 
      'US', 
      'AI', 
      'AG', 
      'AW', 
      'BS', 
      'BB', 
      'KY', 
      'CU', 
      'DM', 
      'DO', 
      'GD', 
      'GP', 
      'HT', 
      'JM', 
      'MQ', 
      'MS', 
      'PR', 
      'BL', 
      'KN', 
      'LC', 
      'MF', 
      'VC', 
      'TT', 
      'TC', 
      'VG', 
      'VI', 
      'BZ', 
      'CR', 
      'SV', 
      'GT', 
      'HN', 
      'MX', 
      'NI', 
      'PA', 
      'AR', 
      'BO', 
      'BR', 
      'CL', 
      'CO', 
      'EC', 
      'FK', 
      'GF', 
      'GY', 
      'PY', 
      'PE', 
      'SR', 
      'UY', 
      'VE'] + @search.regions.split("; ")
    end

    if (@search.regions.include?('Europe'))
      @search.regions = ['AX', 
      'DK', 
      'EE', 
      'FO', 
      'FI', 
      'GG', 
      'IS', 
      'IE', 
      'IM', 
      'JE', 
      'LV', 
      'LT', 
      'NO', 
      'SJ', 
      'SE', 
      'GB', 
      'AT', 
      'BE', 
      'FR', 
      'DE', 
      'LI', 
      'LU', 
      'MC', 
      'NL', 
      'CH', 
      'BY', 
      'BG', 
      'CZ', 
      'HU', 
      'MD', 
      'PL', 
      'RO', 
      'RU', 
      'SK', 
      'UA', 
      'AL', 
      'AD', 
      'BA', 
      'HR', 
      'GI', 
      'GR', 
      'VA', 
      'IT', 
      'MK', 
      'MT', 
      'ME', 
      'PT', 
      'SM', 
      'RS', 
      'SI', 
      'ES'] + @search.regions.split("; ")
    end

    if (@search.regions.include?('Africa'))
      @search.regions = ['DZ', 
      'EG', 
      'LY', 
      'MA', 
      'SD', 
      'TN', 
      'EH', 
      'BJ', 
      'BF', 
      'CV', 
      'CI', 
      'GM', 
      'GH', 
      'GN', 
      'GW', 
      'LR', 
      'ML', 
      'MR', 
      'NE', 
      'NG', 
      'SH', 
      'SN', 
      'SL', 
      'TG', 
      'AO', 
      'CM', 
      'CF', 
      'TD', 
      'CG', 
      'CD', 
      'GQ', 
      'GA', 
      'ST', 
      'BI', 
      'KM', 
      'DJ', 
      'ER', 
      'ET', 
      'KE', 
      'MG', 
      'MW', 
      'MU', 
      'YT', 
      'MZ', 
      'RE', 
      'RW', 
      'SC', 
      'SO', 
      'TZ', 
      'UG', 
      'ZM', 
      'ZW', 
      'BW', 
      'LS', 
      'NA', 
      'ZA', 
      'SZ'] + @search.regions.split("; ")
    end

    if (@search.regions.include?('Asia'))
      @search.regions = ['KZ', 
      'KG', 
      'TJ', 
      'TM', 
      'UZ', 
      'CN', 
      'HK', 
      'JP', 
      'KP', 
      'KR', 
      'MO', 
      'MN', 
      'TW', 
      'AF', 
      'BD', 
      'BT', 
      'IN', 
      'IR', 
      'MV', 
      'NP', 
      'PK', 
      'LK', 
      'BN', 
      'KH', 
      'ID', 
      'LA', 
      'MY', 
      'MM', 
      'PH', 
      'SG', 
      'TH', 
      'TL', 
      'VN', 
      'AM', 
      'AZ', 
      'BH', 
      'CY', 
      'GE', 
      'IQ', 
      'IL', 
      'JO', 
      'KW', 
      'LB', 
      'OM', 
      'PS', 
      'QA', 
      'SA', 
      'SY', 
      'TR', 
      'AE', 
      'YE'] + @search.regions.split("; ")
    end

    if (@search.regions.include?('Oceania'))
      @search.regions = ['AU', 
      'NZ', 
      'NF', 
      'FJ', 
      'NC', 
      'PG', 
      'SB', 
      'VU', 
      'GU', 
      'KI', 
      'MH', 
      'FM', 
      'NR', 
      'MP', 
      'PW', 
      'AS', 
      'CK', 
      'PF', 
      'NU', 
      'PN', 
      'WS', 
      'TK', 
      'TO', 
      'TV', 
      'WF'] + @search.regions.split("; ")
    end
    
    
    if @search.regions.include?("false")
      @search.regions = ['DZ', 
      'EG', 
      'LY', 
      'MA', 
      'SD', 
      'TN', 
      'EH', 
      'BJ', 
      'BF', 
      'CV', 
      'CI', 
      'GM', 
      'GH', 
      'GN', 
      'GW', 
      'LR', 
      'ML', 
      'MR', 
      'NE', 
      'NG', 
      'SH', 
      'SN', 
      'SL', 
      'TG', 
      'AO', 
      'CM', 
      'CF', 
      'TD', 
      'CG', 
      'CD', 
      'GQ', 
      'GA', 
      'ST', 
      'BI', 
      'KM', 
      'DJ', 
      'ER', 
      'ET', 
      'KE', 
      'MG', 
      'MW', 
      'MU', 
      'YT', 
      'MZ', 
      'RE', 
      'RW', 
      'SC', 
      'SO', 
      'TZ', 
      'UG', 
      'ZM', 
      'ZW', 
      'BW', 
      'LS', 
      'NA', 
      'ZA', 
      'SZ',
      'AX', 
      'DK', 
      'EE', 
      'FO', 
      'FI', 
      'GG', 
      'IS', 
      'IE', 
      'IM', 
      'JE', 
      'LV', 
      'LT', 
      'NO', 
      'SJ', 
      'SE', 
      'GB', 
      'AT', 
      'BE', 
      'FR', 
      'DE', 
      'LI', 
      'LU', 
      'MC', 
      'NL', 
      'CH', 
      'BY', 
      'BG', 
      'CZ', 
      'HU', 
      'MD', 
      'PL', 
      'RO', 
      'RU', 
      'SK', 
      'UA', 
      'AL', 
      'AD', 
      'BA', 
      'HR', 
      'GI', 
      'GR', 
      'VA', 
      'IT', 
      'MK', 
      'MT', 
      'ME', 
      'PT', 
      'SM', 
      'RS', 
      'SI', 
      'ES',
      'BM', 
      'CA', 
      'GL', 
      'PM', 
      'US', 
      'AI', 
      'AG', 
      'AW', 
      'BS', 
      'BB', 
      'KY', 
      'CU', 
      'DM', 
      'DO', 
      'GD', 
      'GP', 
      'HT', 
      'JM', 
      'MQ', 
      'MS', 
      'PR', 
      'BL', 
      'KN', 
      'LC', 
      'MF', 
      'VC', 
      'TT', 
      'TC', 
      'VG', 
      'VI', 
      'BZ', 
      'CR', 
      'SV', 
      'GT', 
      'HN', 
      'MX', 
      'NI', 
      'PA', 
      'AR', 
      'BO', 
      'BR', 
      'CL', 
      'CO', 
      'EC', 
      'FK', 
      'GF', 
      'GY', 
      'PY', 
      'PE', 
      'SR', 
      'UY', 
      'VE',
      'KZ', 
      'KG', 
      'TJ', 
      'TM', 
      'UZ', 
      'CN', 
      'HK', 
      'JP', 
      'KP', 
      'KR', 
      'MO', 
      'MN', 
      'TW', 
      'AF', 
      'BD', 
      'BT', 
      'IN', 
      'IR', 
      'MV', 
      'NP', 
      'PK', 
      'LK', 
      'BN', 
      'KH', 
      'ID', 
      'LA', 
      'MY', 
      'MM', 
      'PH', 
      'SG', 
      'TH', 
      'TL', 
      'VN', 
      'AM', 
      'AZ', 
      'BH', 
      'CY', 
      'GE', 
      'IQ', 
      'IL', 
      'JO', 
      'KW', 
      'LB', 
      'OM', 
      'PS', 
      'QA', 
      'SA', 
      'SY', 
      'TR', 
      'AE', 
      'YE',
      'AU', 
      'NZ', 
      'NF', 
      'FJ', 
      'NC', 
      'PG', 
      'SB', 
      'VU', 
      'GU', 
      'KI', 
      'MH', 
      'FM', 
      'NR', 
      'MP', 
      'PW', 
      'AS', 
      'CK', 
      'PF', 
      'NU', 
      'PN', 
      'WS', 
      'TK', 
      'TO', 
      'TV', 
      'WF', 
      'Africa',
      'Asia',
      'Oceania',
      'Americas',
      'Europe']
    end
    if @search.sizes.include?("false")
      @search.sizes = ["Individual", "Small Groups (2-3)", "Medium Groups (4-10)", "Large Groups (11+)"]
    end
    
    
    @search.regions = @search.regions.join("; ")
    @search.subjects = @search.subjects.join("; ")
    @search.sizes = @search.sizes.join("; ") unless @search.sizes.class.name == "String"

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
    
    if params[:search][:subjects].include?('Agriculture')
      params[:search][:subjects] = ['Organic Farming', 'Sustainable Development'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Animal Care')
      params[:search][:subjects] = ['Animal Rights', 'Wildlife Conservation'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Caregiving')
      params[:search][:subjects] = ['Elder Care', 'Child/Orphan Care', 'Disabled Care', 'Feed the Homeless'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Community Development')
      params[:search][:subjects] = ['Youth Development and Outreach'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Culture and Community')
      params[:search][:subjects] = ['Performing Arts', 'Fashion', 'Music', 'Sports & Recreation', 'Journalism'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Disaster Relief')
      params[:search][:subjects] = ['Economics', 'Microfinance'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Education')
      params[:search][:subjects] = ['Teaching Buddhist Monks', 'Teaching Children', 'Teaching Computer Literacy'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Environmental')
      params[:search][:subjects] = ['Ecological Conservation', 'Sustainable Development', 'Wildlife Conservation', 'Habitat Restoration'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Health and Medicine')
      params[:search][:subjects] = ['HIV/AIDS', 'Family Planning', 'Nutrition', 'Veterinary Medicine', 'Clinical Work', 'Dental Work', 'Medical Research', 'Health Education', 'Public Health', 'Hospital Caregiving'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Human Rights')
      params[:search][:subjects] = ['Womens Initiatives'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Recreation')
      params[:search][:subjects] = ['Adventure Travel'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Scientific Research')
      params[:search][:subjects] = ['Archaeology', 'Environmental Biology'] + (params[:search][:subjects].split("; "))
    end
    if params[:search][:subjects].include?('Technology')
      params[:search][:subjects] = ['Teaching Computer Literacy', 'Media Marketing and Graphic Design'] + (params[:search][:subjects].split("; "))
    end
    
    if params[:search][:subjects].include?("false")
      params[:search][:subjects] = ['Agriculture', 
        'Organic Farming', 
        'Sustainable Development', 
        'Animal Care', 
        'Animal Rights', 
        'Wildlife Conservation', 
        'Caregiving', 
        'Elder Care', 
        'Child/Orphan Care', 
        'Disabled Care', 
        'Feed the Homeless', 
        'Community Development', 
        'Youth Development and Outreach', 
        'Construction', 
        'Culture and Community', 
        'Performing Arts', 
        'Fashion', 
        'Music', 
        'Sports & Recreation', 
        'Journalism', 
        'Disaster Relief', 
        'Economics', 
        'Microfinance', 
        'Education', 
        'Teaching English', 
        'Teaching Buddhist Monks', 
        'Teaching Children', 
        'Teaching Computer Literacy', 
        'Engineering and Infrastructure', 
        'Environmental', 
        'Ecological Conservation', 
        'Sustainable Development', 
        'Wildlife Conservation', 
        'Habitat Restoration', 
        'Health and Medicine', 
        'HIV/AIDS', 
        'Nutrition', 
        'Family Planning', 
        'Veterinary Medicine', 
        'Clinical Work', 
        'Dental Work', 
        'Medical Research', 
        'Health Education', 
        'Public Health', 
        'Hospital Care-giving', 
        'Human Rights', 
        'Womens Initiatives', 
        'International Work Camp', 
        'Recreation', 
        'Adventure Travel', 
        'Scientific Research', 
        'Archaeology', 
        'Environmental Biology', 
        'Technology', 
        'Teaching Computer Literacy', 
        'Media Marketing and Graphic Design']
    end
    
    

    if (params[:search][:regions].include?('Americas'))
      params[:search][:regions] = ['BM', 
      'CA', 
      'GL', 
      'PM', 
      'US', 
      'AI', 
      'AG', 
      'AW', 
      'BS', 
      'BB', 
      'KY', 
      'CU', 
      'DM', 
      'DO', 
      'GD', 
      'GP', 
      'HT', 
      'JM', 
      'MQ', 
      'MS', 
      'PR', 
      'BL', 
      'KN', 
      'LC', 
      'MF', 
      'VC', 
      'TT', 
      'TC', 
      'VG', 
      'VI', 
      'BZ', 
      'CR', 
      'SV', 
      'GT', 
      'HN', 
      'MX', 
      'NI', 
      'PA', 
      'AR', 
      'BO', 
      'BR', 
      'CL', 
      'CO', 
      'EC', 
      'FK', 
      'GF', 
      'GY', 
      'PY', 
      'PE', 
      'SR', 
      'UY', 
      'VE'] + params[:search][:regions].split("; ")
    end

    if (params[:search][:regions].include?('Europe'))
      params[:search][:regions] = ['AX', 
      'DK', 
      'EE', 
      'FO', 
      'FI', 
      'GG', 
      'IS', 
      'IE', 
      'IM', 
      'JE', 
      'LV', 
      'LT', 
      'NO', 
      'SJ', 
      'SE', 
      'GB', 
      'AT', 
      'BE', 
      'FR', 
      'DE', 
      'LI', 
      'LU', 
      'MC', 
      'NL', 
      'CH', 
      'BY', 
      'BG', 
      'CZ', 
      'HU', 
      'MD', 
      'PL', 
      'RO', 
      'RU', 
      'SK', 
      'UA', 
      'AL', 
      'AD', 
      'BA', 
      'HR', 
      'GI', 
      'GR', 
      'VA', 
      'IT', 
      'MK', 
      'MT', 
      'ME', 
      'PT', 
      'SM', 
      'RS', 
      'SI', 
      'ES'] + params[:search][:regions].split("; ")
    end

    if (params[:search][:regions].include?('Africa'))
      params[:search][:regions] = ['DZ', 
      'EG', 
      'LY', 
      'MA', 
      'SD', 
      'TN', 
      'EH', 
      'BJ', 
      'BF', 
      'CV', 
      'CI', 
      'GM', 
      'GH', 
      'GN', 
      'GW', 
      'LR', 
      'ML', 
      'MR', 
      'NE', 
      'NG', 
      'SH', 
      'SN', 
      'SL', 
      'TG', 
      'AO', 
      'CM', 
      'CF', 
      'TD', 
      'CG', 
      'CD', 
      'GQ', 
      'GA', 
      'ST', 
      'BI', 
      'KM', 
      'DJ', 
      'ER', 
      'ET', 
      'KE', 
      'MG', 
      'MW', 
      'MU', 
      'YT', 
      'MZ', 
      'RE', 
      'RW', 
      'SC', 
      'SO', 
      'TZ', 
      'UG', 
      'ZM', 
      'ZW', 
      'BW', 
      'LS', 
      'NA', 
      'ZA', 
      'SZ'] + params[:search][:regions].split("; ")
    end

    if (params[:search][:regions].include?('Asia'))
      params[:search][:regions] = ['KZ', 
      'KG', 
      'TJ', 
      'TM', 
      'UZ', 
      'CN', 
      'HK', 
      'JP', 
      'KP', 
      'KR', 
      'MO', 
      'MN', 
      'TW', 
      'AF', 
      'BD', 
      'BT', 
      'IN', 
      'IR', 
      'MV', 
      'NP', 
      'PK', 
      'LK', 
      'BN', 
      'KH', 
      'ID', 
      'LA', 
      'MY', 
      'MM', 
      'PH', 
      'SG', 
      'TH', 
      'TL', 
      'VN', 
      'AM', 
      'AZ', 
      'BH', 
      'CY', 
      'GE', 
      'IQ', 
      'IL', 
      'JO', 
      'KW', 
      'LB', 
      'OM', 
      'PS', 
      'QA', 
      'SA', 
      'SY', 
      'TR', 
      'AE', 
      'YE'] + params[:search][:regions].split("; ")
    end

    if (params[:search][:regions].include?('Oceania'))
      params[:search][:regions] = ['AU', 
      'NZ', 
      'NF', 
      'FJ', 
      'NC', 
      'PG', 
      'SB', 
      'VU', 
      'GU', 
      'KI', 
      'MH', 
      'FM', 
      'NR', 
      'MP', 
      'PW', 
      'AS', 
      'CK', 
      'PF', 
      'NU', 
      'PN', 
      'WS', 
      'TK', 
      'TO', 
      'TV', 
      'WF'] + params[:search][:regions].split("; ")
    end
    
    
    if params[:search][:regions].include?("false")
      params[:search][:regions] = ['DZ', 
      'EG', 
      'LY', 
      'MA', 
      'SD', 
      'TN', 
      'EH', 
      'BJ', 
      'BF', 
      'CV', 
      'CI', 
      'GM', 
      'GH', 
      'GN', 
      'GW', 
      'LR', 
      'ML', 
      'MR', 
      'NE', 
      'NG', 
      'SH', 
      'SN', 
      'SL', 
      'TG', 
      'AO', 
      'CM', 
      'CF', 
      'TD', 
      'CG', 
      'CD', 
      'GQ', 
      'GA', 
      'ST', 
      'BI', 
      'KM', 
      'DJ', 
      'ER', 
      'ET', 
      'KE', 
      'MG', 
      'MW', 
      'MU', 
      'YT', 
      'MZ', 
      'RE', 
      'RW', 
      'SC', 
      'SO', 
      'TZ', 
      'UG', 
      'ZM', 
      'ZW', 
      'BW', 
      'LS', 
      'NA', 
      'ZA', 
      'SZ',
      'AX', 
      'DK', 
      'EE', 
      'FO', 
      'FI', 
      'GG', 
      'IS', 
      'IE', 
      'IM', 
      'JE', 
      'LV', 
      'LT', 
      'NO', 
      'SJ', 
      'SE', 
      'GB', 
      'AT', 
      'BE', 
      'FR', 
      'DE', 
      'LI', 
      'LU', 
      'MC', 
      'NL', 
      'CH', 
      'BY', 
      'BG', 
      'CZ', 
      'HU', 
      'MD', 
      'PL', 
      'RO', 
      'RU', 
      'SK', 
      'UA', 
      'AL', 
      'AD', 
      'BA', 
      'HR', 
      'GI', 
      'GR', 
      'VA', 
      'IT', 
      'MK', 
      'MT', 
      'ME', 
      'PT', 
      'SM', 
      'RS', 
      'SI', 
      'ES',
      'BM', 
      'CA', 
      'GL', 
      'PM', 
      'US', 
      'AI', 
      'AG', 
      'AW', 
      'BS', 
      'BB', 
      'KY', 
      'CU', 
      'DM', 
      'DO', 
      'GD', 
      'GP', 
      'HT', 
      'JM', 
      'MQ', 
      'MS', 
      'PR', 
      'BL', 
      'KN', 
      'LC', 
      'MF', 
      'VC', 
      'TT', 
      'TC', 
      'VG', 
      'VI', 
      'BZ', 
      'CR', 
      'SV', 
      'GT', 
      'HN', 
      'MX', 
      'NI', 
      'PA', 
      'AR', 
      'BO', 
      'BR', 
      'CL', 
      'CO', 
      'EC', 
      'FK', 
      'GF', 
      'GY', 
      'PY', 
      'PE', 
      'SR', 
      'UY', 
      'VE',
      'KZ', 
      'KG', 
      'TJ', 
      'TM', 
      'UZ', 
      'CN', 
      'HK', 
      'JP', 
      'KP', 
      'KR', 
      'MO', 
      'MN', 
      'TW', 
      'AF', 
      'BD', 
      'BT', 
      'IN', 
      'IR', 
      'MV', 
      'NP', 
      'PK', 
      'LK', 
      'BN', 
      'KH', 
      'ID', 
      'LA', 
      'MY', 
      'MM', 
      'PH', 
      'SG', 
      'TH', 
      'TL', 
      'VN', 
      'AM', 
      'AZ', 
      'BH', 
      'CY', 
      'GE', 
      'IQ', 
      'IL', 
      'JO', 
      'KW', 
      'LB', 
      'OM', 
      'PS', 
      'QA', 
      'SA', 
      'SY', 
      'TR', 
      'AE', 
      'YE',
      'AU', 
      'NZ', 
      'NF', 
      'FJ', 
      'NC', 
      'PG', 
      'SB', 
      'VU', 
      'GU', 
      'KI', 
      'MH', 
      'FM', 
      'NR', 
      'MP', 
      'PW', 
      'AS', 
      'CK', 
      'PF', 
      'NU', 
      'PN', 
      'WS', 
      'TK', 
      'TO', 
      'TV', 
      'WF',
      'Africa',
      'Asia',
      'Oceania',
      'Americas',
      'Europe']
    end
    if params[:search][:sizes].include?("false")
      params[:search][:sizes] = ["Individual", "Small Groups (2-3)", "Medium Groups (4-10)", "Large Groups (11+)"]
    end
     params[:search][:regions] = params[:search][:regions].join("; ")
      params[:search][:subjects] = params[:search][:subjects].join("; ")
      params[:search][:sizes] = params[:search][:sizes].join("; ") unless params[:search][:sizes].class.name == "String"
    
    
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
