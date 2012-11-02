class ProgramsController < ApplicationController

	include ActionView::Helpers::TextHelper
	require 'aws/s3'
	
	
	# search results page for all means of searching
	def search_results
	  @search = Program.search do
	    fulltext params[:search] if params[:search].present?
	    facet(:program_subjects)
	    with(:program_subjects, params[:subject]) if params[:subject].present?
	  end
	  @programs = @search.results
	end


  # GET /programs/1
  # GET /programs/1.json
  def show
    @program = Program.find(params[:id])
    @entries = []
    @program.program_cost_length_maps.sort_by(&:length).each do |p|
      @entries << [(p.length / 604800).round, p.cost]
    end
    
     @results = Review.where(:program_id => @program.id).sort_by(&:created_at).reverse
     @overall = 0
     @results.each do |f|
       @overall = @overall + f.overall
     end
     if @results.count != 0
       @overall = @overall / @results.count
     else
       @overall = 0
     end
     @flag = Flag.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @program }
    end
  end

  # GET /programs/new
  # GET /programs/new.json
  def new
    @program = Program.new
    @costs = []
     @small = false unless !@small.nil? 
     @individual = false unless !@individual.nil? 
     @medium = false unless !@medium.nil? 
     @large = false unless !@large.nil? 
    
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @program }
    end
  end

  # GET /programs/1/edit
  def edit
    @program = Program.find(params[:id])
    @program.description = Nokogiri::HTML.fragment(@program.description).text
    @program.program_structure = Nokogiri::HTML.fragment(@program.program_structure).text
    @program.program_cost_breakdown = Nokogiri::HTML.fragment(@program.program_cost_breakdown).text
    @program.cost_includes = Nokogiri::HTML.fragment(@program.cost_includes).text
    @program.cost_doesnt_include = Nokogiri::HTML.fragment(@program.cost_doesnt_include).text
    @program.accommodations = Nokogiri::HTML.fragment(@program.accommodations).text
    
    @subjects = @program.program_subjects.map(&:subject)
    @sizes = @program.program_sizes.map(&:size)
    
    
    if @sizes.include?("Individual")
      @individual = true
    else
      @individual = false
    end
    
    if @sizes.include?("Small Groups (2-3)")
      @small = true
    else
      @small = false
    end
    
    if @sizes.include?("Medium Groups (4-10)")
      @medium = true
    else
      @medium = false
    end
    
    if @sizes.include?("Large Groups (11+)")
      @large = true
    else
      @large = false
    end
    
    
    @costs = @program.program_cost_length_maps.map(&:cost)
    @lengths = @program.program_cost_length_maps.map{|p| "#{p.length_number} #{p.length_name}"}
    
    
    if (current_organization_account.nil?)
      if !(user_signed_in? && current_user.admin?)
        redirect_to root_path       
      end
    end
    
    
  end

  # POST /programs
  # POST /programs.json
  def create
   
    if !(current_organization_account.nil?)
      @org_id = current_organization_account.organization_id
    else
      if !Organization.where(:name => params[:program][:organization_name]).empty?
        @org_id = Organization.where(:name => params[:program][:organization_name]).first.id
      end
    end
    
    @subjects = []
    if !params[:program][:program_subjects].nil?
      params[:program][:program_subjects].split(", ").each do |f|
        @p = ProgramSubject.new(:program_id => params[:program][:id], :subject => f, :organization_id => @org_id)
        @subjects << @p
      end
    end
    params[:program][:program_subjects] = @subjects
    
    @sizes = []
    if !params[:program][:program_sizes].nil?
      params[:program][:program_sizes].each do |f|
        @p = ProgramSize.new(:program_id => params[:program][:id], :size => f, :organization_id => @org_id)
        @sizes << @p
      end
    end
    params[:program][:program_sizes] = @sizes
    
    @cost_lengths = []
    if !params[:costs].nil?
      params[:costs].each do |f|
        @p = ProgramCostLengthMap.new(:program_id => params[:program][:id], :cost => f.to_f, :organization_id => @org_id)
        @cost_lengths << @p
      end
    end
    
    count = 0
    if !params[:lengths].nil?
      params[:lengths].each do |f|
        @p = @cost_lengths[count]
        @length = f.split(" ")
        @p.length = @length[0].to_i.send(@length[1]).to_f
        @p.length_name = @length[1]
        @p.length_number = @length[0]
        @cost_lengths[count] = @p
        count = count + 1
      end
    end
    
    params[:program][:program_cost_length_maps] = @cost_lengths
    
    @program = Program.new(params[:program])
    @program.location_name = THECOUNTRIES[@program.location]
    @program.organization_id = @org_id
    @program.truncated_description100 = RedCloth.new( ActionController::Base.helpers.sanitize(truncate @program.description, :length => 100), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @program.description = RedCloth.new( ActionController::Base.helpers.sanitize( @program.description ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @program.program_cost_breakdown = RedCloth.new( ActionController::Base.helpers.sanitize( @program.program_cost_breakdown ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html 
    @program.cost_includes = RedCloth.new( ActionController::Base.helpers.sanitize( @program.cost_includes ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @program.cost_doesnt_include = RedCloth.new( ActionController::Base.helpers.sanitize( @program.cost_doesnt_include ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @program.accommodations = RedCloth.new( ActionController::Base.helpers.sanitize( @program.accommodations ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    
    
    if (@program.overall.nil?) 
      @program.overall= 0;
    end
    
    if @program.check_it_out[0..3] != "http"
      @program.check_it_out = "http://"+@program.check_it_out
    end

    if (user_signed_in? && current_user.admin?) || organization_account_signed_in?
      if @program.save
            @cost_lengths.each do |f|
              f.program_id = @program.id
              f.save!
              f.index!
            end
            @subjects.each do |s|
              s.program_id = @program.id
              s.save!
            end
            @sizes.each do |a|
              a.program_id = @program.id
              a.save!
            end
          redirect_to @program
      else
        @program.description = Nokogiri::HTML.fragment(@program.description).text
        @program.program_structure = Nokogiri::HTML.fragment(@program.program_structure).text
        @program.program_cost_breakdown = Nokogiri::HTML.fragment(@program.program_cost_breakdown).text
        @program.cost_includes = Nokogiri::HTML.fragment(@program.cost_includes).text
        @program.cost_doesnt_include = Nokogiri::HTML.fragment(@program.cost_doesnt_include).text
        @program.accommodations = Nokogiri::HTML.fragment(@program.accommodations).text
        flash[:notice] = flash[:notice].to_a.concat @program.errors.full_messages
         render :action => "new" 
      end
   else
     redirect_to root_path
   end
end

  # PUT /programs/1
  # PUT /programs/1.json
  def update
    @program = Program.find(params[:id])
    
    
      if (user_signed_in? && current_user.admin?) || organization_account_signed_in?
        @program.program_subjects.each do |f|
          f.destroy
        end
        @program.program_sizes.each do |f|
          f.destroy
        end
        @program.program_cost_length_maps.each do |f|
          f.destroy
        end
        
         @subjects = []
         unless params[:program][:program_subjects].nil?
          params[:program][:program_subjects].split(", ").each do |f|
              @p = ProgramSubject.new(:program_id => params[:id], :subject => f, :organization_id => @program.organization_id)
              @subjects << @p
          end
         end
          params[:program][:program_subjects] = @subjects

          @sizes = []
          unless params[:program][:program_sizes].nil?
          params[:program][:program_sizes].each do |f|
            @p = ProgramSize.new(:program_id => params[:id], :size => f, :organization_id => @program.organization_id)
            @sizes << @p
          end
          end
          params[:program][:program_sizes] = @sizes
          
          @cost_lengths = []
          unless params[:costs].nil?
          params[:costs].each do |f|
            if !(f.nil? || f.empty?)
              @p = ProgramCostLengthMap.new(:program_id => params[:id], :cost => f.to_f, :organization_id => @program.organization_id)
              @cost_lengths << @p
            end
          end
          end

          count = 0
          unless params[:lengths].nil?
          params[:lengths].each do |f|
            @p = @cost_lengths[count]
            @length = f.split(" ")
            @p.length = @length[0].to_i.send(@length[1]).to_f
            @p.length_name = @length[1]
            @p.length_number = @length[0]
            @cost_lengths[count] = @p
            count = count + 1
          end
          end
          
          params[:program][:program_cost_length_maps] = @cost_lengths
      
          params[:program][:description] = RedCloth.new( ActionController::Base.helpers.sanitize( @program.description ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
          params[:program][:program_cost_breakdown] = RedCloth.new( ActionController::Base.helpers.sanitize( @program.program_cost_breakdown ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html 
          params[:program][:cost_includes] = RedCloth.new( ActionController::Base.helpers.sanitize( @program.cost_includes ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
          params[:program][:cost_doesnt_include] = RedCloth.new( ActionController::Base.helpers.sanitize( @program.cost_doesnt_include ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
          params[:program][:accommodations] = RedCloth.new( ActionController::Base.helpers.sanitize( @program.accommodations ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
          
        
      if @program.update_attributes(params[:program])
        @cost_lengths.each do |f|
          f.program_id = @program.id
          f.save!
          f.index!
        end
        @subjects.each do |s|
          s.program_id = @program.id
          s.save!
        end
        @sizes.each do |a|
          a.program_id = @program.id
          a.save!
        end
            respond_to do |format|
               format.html { redirect_to "/programs/#{@program.id}" }
               format.json { head :no_content }
             end
      else
        params[:program][:program_subjects] = @program.program_subjects.map(&:subject).join(", ")
        params[:program][:description] = Nokogiri::HTML.fragment(@program.description).text
        params[:program][:program_structure] = Nokogiri::HTML.fragment(@program.program_structure).text
        params[:program][:program_cost_breakdown] = Nokogiri::HTML.fragment(@program.program_cost_breakdown).text
        params[:program][:cost_includes] = Nokogiri::HTML.fragment(@program.cost_includes).text
        params[:program][:cost_doesnt_include] = Nokogiri::HTML.fragment(@program.cost_doesnt_include).text
        params[:program][:accommodations] = Nokogiri::HTML.fragment(@program.accommodations).text
         flash[:notice] = flash[:notice].to_a.concat @program.errors.full_messages
         flash.now[:notice]
         respond_to do |format|
           format.html { render :action => "edit" }
           format.json { render json: @program.errors, status: :unprocessable_entity }
         end 
      end
   else
     redirect_to root_path
   end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program = Program.find(params[:id])
    if (user_signed_in? && current_user.admin?) || (!current_organization_account.nil?)
    @program.destroy

    respond_to do |format|
      if user_signed_in? && current_user.admin?
        format.html { redirect_to "/organizations" }
      else
        format.html { redirect_to "/organization_accounts/profile" }
      end
      format.json { head :no_content }
    end
  else
    redirect_to root_path
  end
  end
  
end
