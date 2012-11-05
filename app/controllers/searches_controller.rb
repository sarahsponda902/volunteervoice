class SearchesController < ApplicationController

  before_filter :check_for_admin, :only => [:index, :destroy, :erase_old]
  include SearchesHelper
  
  # GET /searches
  # GET /searches.json
  # Shows history of searches for Admin only
  def index
    @searches = Search.all.sort_by(&:updated_at).reverse
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @searches }
    end
  end

  # erase old searches that nobody needs/uses anymore
  def erase_old
      @searches = Search.all
      @searches.each do |search|
        if search.updated_at < 24.hours.ago
          search.destroy
        end
      end
      redirect_to "/searches"
  end

  # if a search has been deleted, show this page
  def error
    @search = Search.new
    @locations = []
    Program.find_each(:batch_size => 200) do |f|
      @locations << f.location unless @locations.include?(f.location)
    end

    @search_regions = regions
    @search_subjects = subjects
    @search_sizes = sizes
    respond_to do |format|
      format.html
    end
  end


  # GET /searches/1
  # GET /searches/1.json
  def show
    if Search.exists?(params[:id]) # if the search hasn't been deleted by admin
      @search = Search.find(params[:id])
      # locations where there are programs to send to javascript on page
       # only locations with programs will be available as facets
       @locations = []
       Program.find_each(:batch_size => 500) do |prog|
         @locations << prog.location unless @locations.include?(prog.location)
       end
       @results = @search.search_results(params[:id])
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

  # the program browse page (select a subject)
  def program_browse_search
    @search = Search.new

    # get the group (array) of subjects that the selected subject corresponds to, 
    #  if the subject is not a main/super category, then set @search.subjects to
    #    an array containing the selected subject.
    @search.subjects = []
    @search.subjects = HASH_OF_SUBJECT_GROUPS[params[:subject]] unless params[:subject].nil?

    # join the subjects by a semicolon to pass & save in the "subjects" parameter of @search
    @search.subjects = @search.subjects.join("; ")

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render json: @search, status: :created, location: @search }
      else
        format.html { render action: "program_browse" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # the advanced search / search machine page
  def search_machine
    @search = Search.new
    @locations = Program.all.map{|prog| prog.location}.uniq 
  end


  def places
    @programs = Program.all  

    # array of all countries that have programs
    @countries_with_programs = @programs.map {|prog| prog.location}.uniq

    # indicies of names of all countries-with-programs in ALLCOUNTRIES
    @nums = @countries_with_programs.map {|country| ALLCOUNTRIES.index(country)}

    # counts of how many programs are in each country
    @progNums = @countries_with_programs.map {|country| Program.where(:location => country).count}

    # create the hashes of countries/programs
    @americas = make_program_country_hash([10, 11, 12, 13]).sort_by { |country| country[1] } 
    @europe = make_program_country_hash([6, 7, 8, 9]).sort_by { |country| country[1] }
    @africa = make_program_country_hash([1, 2, 3, 4, 5]).sort_by { |country| country[1] } 
    @asia = make_program_country_hash([14, 15, 16, 17, 18]).sort_by { |country| country[1] } 
    @oceania = make_program_country_hash([19, 20, 21, 22]).sort_by { |country| country[1] } 


    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @programs }
    end

  end


  def program_browse
    # presenter found in presenters/searches/program_browse_presenter.rb
    @presenter = Searches::ProgramBrowsePresenter.new()

    respond_to do |format|
      format.html
      format.json 
    end
  end




  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(params[:search])
    
    # for POSTs directed from program_browse (subject) page
    @search.subjects = [] << SUBJECTSHASH[params[:subject]] unless params[:subject].nil?
    
    # for POSTs directed from places_browse (map) page
    @search.regions = [] << params[:location] unless params[:location].nil?

    # join all parameters into one string to save to database
    @search.regions = @search.regions.join("; ") unless (@search.regions.class.name == "String" || @search.regions.nil?)
    @search.subjects = @search.subjects.join("; ") unless (@search.subjects.class.name == "String" || @search.subjects.nil?)
    @search.sizes = @search.sizes.join("; ") unless (@search.sizes.class.name == "String" || @search.sizes.nil?)

    # set params if nil
    @search.length_min_param ||= "weeks"
    @search.length_max_param ||= "years"
    @search.length_min_number ||= 0
    @search.length_max_number ||= 2
    @search.price_min ||= 0
    @search.price_max ||= 99999


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
    
    # join array params to strings to write to database
    params[:search][:regions] = params[:search][:regions].join("; ") unless (params[:search][:regions].class.name == "String" || params[:search][:regions].nil?)
    params[:search][:subjects] = params[:search][:subjects].join("; ") unless (params[:search][:subjects].class.name == "String" || params[:search][:subjects].nil?)
    params[:search][:sizes] = params[:search][:sizes].join("; ") unless (params[:search][:sizes].class.name == "String" || params[:search][:sizes].nil?)
 
    # set params if they are nil
    params[:search][:regions] ||= "false"
    params[:search][:subjects] ||= "false"
    params[:search][:sizes] ||= "false"

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
  # Admin only destroy
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :no_content }
    end
  end

  private
  ## check_for_admin called by before_filter
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end
end
