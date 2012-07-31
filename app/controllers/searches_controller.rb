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
     params[:search][:regions] = params[:search][:regions].join("; ") unless params[:search][:regions].class.name == "String"
     params[:search][:subjects] = params[:search][:subjects].join("; ") unless params[:search][:subjects].class.name == "String"
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
