class SearchesController < ApplicationController
  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @searches }
    end
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @search = Search.find(params[:id])
    subjects = @search.subjects.split("; ") unless @search.subjects.nil?
    regions = @search.regions.split("; ") unless @search.regions.nil?
    lengths = @search.lengths.split("; ") unless @search.lengths.nil?
    sizes = @search.sizes.split("; ") unless @search.sizes.nil?
    
    if @search.showing == "Programs"
      @the_search = Program.search do
        keywords @search.keywords if !(@search.keywords.nil?)
        
        with(:program_subjects).any_of(subjects) unless @search.subjects.nil?

        with(:location).any_of(regions) unless @search.regions.nil?

        with(:weekly_cost).less_than(@search.price_max) unless @search.price_max.nil?

        with(:weekly_cost).greater_than(@search.price_min) unless @search.price_min.nil?

        with(:program_lengths).any_of(lengths) unless @search.lengths.nil?

        with(:program_sizes).any_of(sizes) unless @search.sizes.nil?
        
        order_by :overall, :desc if @search.sort_by == "ratinghigh"
        
        order_by :overall if @search.sort_by == "ratinglow"
        
        order_by :name if @search.sort_by == "alphabetical"
        
        order_by :weekly_cost, :desc if @search.sort_by == "pricehigh"
        
        order_by :weekly_cost if @search.sort_by == "pricelow"
      end
    else
      @the_search = Organization.search do
        keywords @search.keywords if !(@search.keywords.nil?)
        
        with(:program_subjects).any_of(subjects) unless @search.subjects.nil?

        with(:location).any_of(regions) unless @search.regions.nil?

        with(:program_lengths).any_of(lengths) unless @search.lengths.nil?

        with(:program_sizes).any_of(sizes) unless @search.sizes.nil?
        
        order_by :overall, :desc if @search.sort_by == "ratinghigh"
        
        order_by :overall if @search.sort_by == "ratinglow"
        
        order_by :name if @search.sort_by == "alphabetical"
        
      end
   end     
    @results = @the_search.results
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @search }
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
    @search = Search.new(params[:search])
    
    
    if @search.subjects.include?('Agriculture')
      @search.subjects = ['Organic Farming', 'Sustainable Development'] + (@search.subjects)
    end
    if @search.subjects.include?('Animal Care')
      @search.subjects = ['Animal Rights', 'Wildlife Conservation'] + (@search.subjects)
    end
    if @search.subjects.include?('Caregiving')
      @search.subjects = ['Elder Care', 'Child/Orphan Care', 'Disabled Care', 'Feed the Homeless'] + (@search.subjects)
    end
    if @search.subjects.include?('Community Development')
      @search.subjects = @search.subjects+['Youth Development and Outreach'] + (@search.subjects)
    end
    if @search.subjects.include?('Culture and Community')
      @search.subjects = ['Performing Arts', 'Fashion', 'Music', 'Sports & Recreation', 'Journalism'] + (@search.subjects)
    end
    if @search.subjects.include?('Disaster Relief')
      @search.subjects = ['Economics', 'Microfinance'] + (@search.subjects)
    end
    if @search.subjects.include?('Education')
      @search.subjects = ['Teaching Buddhist Monks', 'Teaching Children', 'Teaching Computer Literacy'] + (@search.subjects)
    end
    if @search.subjects.include?('Environmental')
      @search.subjects = ['Ecological Conservation', 'Sustainable Development', 'Wildlife Conservation', 'Habitat Restoration'] + (@search.subjects)
    end
    if @search.subjects.include?('Health and Medicine')
      @search.subjects = ['HIV/AIDS', 'Family Planning', 'Nutrition', 'Veterinary Medicine', 'Clinical Work', 'Dental Work', 'Medical Research', 'Health Education', 'Public Health', 'Hospital Caregiving'] + (@search.subjects)
    end
    if @search.subjects.include?('Human Rights')
      @search.subjects = ['Womens Initiatives'] + (@search.subjects)
    end
    if @search.subjects.include?('Recreation')
      @search.subjects = ['Adventure Travel'] + (@search.subjects)
    end
    if @search.subjects.include?('Scientific Research')
      @search.subjects = ['Archaeology', 'Environmental Biology'] + (@search.subjects)
    end
    if @search.subjects.include?('Technology')
      @search.subjects = ['Teaching Computer Literacy', 'Media Marketing and Graphic Design'] + (@search.subjects)
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
      'SZ'] + @search.regions
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
      'ES'] + @search.regions
    end

    if (@search.regions.include?('Africa'))
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
      'VE'] + @search.regions
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
      'YE'] + @search.regions
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
      'WF'] + @search.regions
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
      'WF']
    end
    if @search.lengths.include?("false")
       @search.lengths = ["1 week or less", "2-4 weeks", "5-8 weeks", "9-12 weeks", "3-6 months", "6-12 months", "1-2 years", "2+ years"]
    end
    if @search.sizes.include?("false")
      @search.sizes = ["Individual", "Small Groups (2-3)", "Medium Groups (4-10)", "Large Groups (11+)"]
    end
    
    
    @search.regions = @search.regions.join("; ")
    @search.subjects = @search.subjects.join("; ")
    @search.lengths = @search.lengths.join("; ")
    @search.sizes = @search.sizes.join("; ")

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

    
    
    if @search.subjects.include?('Agriculture')
      @search.subjects = ['Organic Farming', 'Sustainable Development'] + (@search.subjects)
    end
    if @search.subjects.include?('Animal Care')
      @search.subjects = ['Animal Rights', 'Wildlife Conservation'] + (@search.subjects)
    end
    if @search.subjects.include?('Caregiving')
      @search.subjects = ['Elder Care', 'Child/Orphan Care', 'Disabled Care', 'Feed the Homeless'] + (@search.subjects)
    end
    if @search.subjects.include?('Community Development')
      @search.subjects = @search.subjects+['Youth Development and Outreach'] + (@search.subjects)
    end
    if @search.subjects.include?('Culture and Community')
      @search.subjects = ['Performing Arts', 'Fashion', 'Music', 'Sports & Recreation', 'Journalism'] + (@search.subjects)
    end
    if @search.subjects.include?('Disaster Relief')
      @search.subjects = ['Economics', 'Microfinance'] + (@search.subjects)
    end
    if @search.subjects.include?('Education')
      @search.subjects = ['Teaching Buddhist Monks', 'Teaching Children', 'Teaching Computer Literacy'] + (@search.subjects)
    end
    if @search.subjects.include?('Environmental')
      @search.subjects = ['Ecological Conservation', 'Sustainable Development', 'Wildlife Conservation', 'Habitat Restoration'] + (@search.subjects)
    end
    if @search.subjects.include?('Health and Medicine')
      @search.subjects = ['HIV/AIDS', 'Family Planning', 'Nutrition', 'Veterinary Medicine', 'Clinical Work', 'Dental Work', 'Medical Research', 'Health Education', 'Public Health', 'Hospital Caregiving'] + (@search.subjects)
    end
    if @search.subjects.include?('Human Rights')
      @search.subjects = ['Womens Initiatives'] + (@search.subjects)
    end
    if @search.subjects.include?('Recreation')
      @search.subjects = ['Adventure Travel'] + (@search.subjects)
    end
    if @search.subjects.include?('Scientific Research')
      @search.subjects = ['Archaeology', 'Environmental Biology'] + (@search.subjects)
    end
    if @search.subjects.include?('Technology')
      @search.subjects = ['Teaching Computer Literacy', 'Media Marketing and Graphic Design'] + (@search.subjects)
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
      'SZ'] + @search.regions
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
      'ES'] + @search.regions
    end

    if (@search.regions.include?('Africa'))
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
      'VE'] + @search.regions
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
      'YE'] + @search.regions
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
      'WF'] + @search.regions
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
      'WF']
    end
    if @search.lengths.include?("false")
       @search.lengths = ["1 week or less", "2-4 weeks", "5-8 weeks", "9-12 weeks", "3-6 months", "6-12 months", "1-2 years", "2+ years"]
    end
    if @search.sizes.include?("false")
      @search.sizes = ["Individual", "Small Groups (2-3)", "Medium Groups (4-10)", "Large Groups (11+)"]
    end
    
    
    @search.regions = @search.regions.join("; ")
    @search.subjects = @search.subjects.join("; ")
    @search.lengths = @search.lengths.join("; ")
    @search.sizes = @search.sizes.join("; ")
    
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
