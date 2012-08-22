class OrganizationsController < ApplicationController
  # GET /organizations
  # GET /organizations.json
  
	require 'aws/s3'
  include ActionView::Helpers::TextHelper
  
  
  def show_all
    @sort_by = params[:sort_by]
    if @sort_by.nil? || @sort_by == "rating_high"
      @organizations = Organization.all.sort_by(&:overall).reverse
    elsif @sort_by == "rating_low"
      @organizations = Organization.all.sort_by(&:overall)
    elsif @sort_by == "review_recent"
      @organizations = Organization.all.sort_by(&:latest_review_time)
    elsif @sort_by == "profiled_recent"
      @organizations = Organization.all.sort_by(&:created_at)
    elsif @sort_by == "alphabetical_az"
      @organizations = Organization.all.sort_by(&:name)
    else
      @organizations = Organization.all.sort_by(&:name).reverse
    end
        
  end
  
  def index
    if user_signed_in? && current_user.admin?
      @organizations = Organization.all
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @organizations }
      end
    else
        redirect_to root_path
    end
  end



  
  def crop
    if user_signed_in? && current_user.admin?
      @organization = Organization.find(params[:id])
    else
      redirect_to "/organizations/#{params[:id]}"
    end
  end

  # GET /organizations/1
  # GET /organizations/1.json

   
  def show 

    
    @flag = Flag.new
    @organization = Organization.find(params[:id])
    
    
    @sorted = ProgramCostLengthMap.where(:organization_id => @organization.id).sort_by(&:length)
    @lengths = []
    @sorted.each do |f|
      @lengths << f.length unless @lengths.include?(f.length)
    end
    @grouped = []
    @lengths.each do |f|
      @grouped << ProgramCostLengthMap.where(:organization_id => @organization.id, :length => f)
    end
    @entries = []
    @grouped.each do |a|
      @sorted_group = a.sort_by(&:cost)
      @entries << [(a.first.length / 604800).round, a.first.cost, a.last.cost]
    end
    
    if (user_signed_in? && current_user.admin?) || (organization_account_signed_in? && current_organization_account.organization_id == @organization.id)
      @can_edit = true
    else
      @can_edit = false
    end
    
    @types_of_programs = []
    @price_ranges = []
    @group_sizes = []
    @program_lengths = []
    
     @organization.programs.each do |f|
       @types_of_programs << f.subject unless @types_of_programs.include?(f.subject)
       @price_ranges  << f.weekly_cost unless @price_ranges.include?(f.weekly_cost)
       @group_sizes << f.group_size unless @group_sizes.include?(f.group_size)
       @program_lengths << f.length unless @program_lengths.include?(f.length)
     end
     @results = []
     Review.where(:organization_id => @organization.id).each do |f|
   	     if !(f.overall.nil?)
           @results << f
       end
     end
     @results = @results.sort_by(&:created_at).reverse
     
     @overall = 0
     @results.each do |f|
       @overall = @overall + f.overall
     end
     if @results.count != 0
       @overall = @overall / @results.count
     else
       @overall = 0
     end
     
     
     @countries = []
     @organization.programs.each do |f|
       if !(@countries.include?(f.location))
         @countries << f.location
       end
     end
   
   @nameCountries = @countries
   
   @progs = Hash.new
   
   @countries.each do |f|
     @progs[f] = Program.where(:location => f)
   end
   
   
    @programSubjects = []
    @groupSizes = []
    @programLengths = []

    @organization.program_subjects.each do |f|
      @programSubjects << f.subject unless @programSubjects.include?(f.subject)
    end 

    @organization.program_sizes.each do |f|
      @groupSizes << f.size unless @groupSizes.include?(f.size)
    end 

    @organization.program_cost_length_maps.sort_by(&:length).each do |f|
      @programLengths << [f.length_number, f.length_name].join(" ") unless @programLengths.include?([f.length_number, f.length_name].join(" ")) 
    end 
    
    @organization.page_views = (@organization.page_views + 1)
     @organization.save! 




    
   
   respond_to do |format|
     format.html
     format.xml  { render :xml => @organization.to_xml }
     format.json { render :json => @organization.as_json }
   end
 end

  
  
  
  # GET /organizations/new
  # GET /organizations/new.json
  def new
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
    if user_signed_in? && (current_user.admin? || (current_user.org && @organization.id == current_user.organization_id))
    @organization = Organization.find(params[:id])
    @organization.description = @organization.description.gsub(%r{</?[^>]+?>}, '')
    @organization.headquarters_location = @organization.headquarters_location.gsub(%r{</?[^>]+?>}, '')
    @organization.good_to_know = @organization.good_to_know.gsub(%r{</?[^>]+?>}, '')
    @organization.training_resources = @organization.training_resources.gsub(%r{</?[^>]+?>}, '')
    @organization.misson = @organization.misson.gsub(%r{</?[^>]+?>}, '')
    @organization.program_costs_includes = @organization.program_costs_includes.gsub(%r{</?[^>]+?>}, '')
    @organization.program_costs_doesnt_include = @organization.program_costs_doesnt_include.gsub(%r{</?[^>]+?>}, '')
    @organization.price_breakdown = @organization.price_breakdown.gsub(%r{</?[^>]+?>}, '')
    @organization.application_process = @organization.application_process.gsub(%r{</?[^>]+?>}, '')
    
  else
    redirect_to root_path
  end
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])
    @organization.truncated75 = RedCloth.new( ActionController::Base.helpers.sanitize( truncate @organization.description, :length => 50), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.description = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.description ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.headquarters_location = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.headquarters_location ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html   
    @organization.good_to_know = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.good_to_know ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.training_resources = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.training_resources ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.misson = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.misson ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.program_costs_includes = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.program_costs_includes ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.program_costs_doesnt_include = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.program_costs_doesnt_include ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.price_breakdown = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.price_breakdown ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @organization.application_process = RedCloth.new( ActionController::Base.helpers.sanitize( @organization.application_process ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    
     
    if @organization.url[0..3] != "http"
      @organization.url = "http://"+@organization.url
    end
    @organization.reviews_count = 0
    @organization.overall = 0
    
    if user_signed_in? && current_user.admin?
      if @organization.save
        @organization.index!
            if @organization.will_invite && @organization.invite_email.present?
              OrganizationAccount.invite!(:email => @organization.invite_email, :organization_id => @organization.id, :admin_pass => admin_pass)
            end
            redirect_to "/organizations/#{@organization.id}/crop"
      else
        @organization.description = @organization.description.gsub(%r{</?[^>]+?>}, '')
        @organization.headquarters_location = @organization.headquarters_location.gsub(%r{</?[^>]+?>}, '')
        @organization.good_to_know = @organization.good_to_know.gsub(%r{</?[^>]+?>}, '')
        @organization.training_resources = @organization.training_resources.gsub(%r{</?[^>]+?>}, '')
        @organization.misson = @organization.misson.gsub(%r{</?[^>]+?>}, '')
        @organization.program_costs_includes = @organization.program_costs_includes.gsub(%r{</?[^>]+?>}, '')
        @organization.program_costs_doesnt_include = @organization.program_costs_doesnt_include.gsub(%r{</?[^>]+?>}, '')
        @organization.price_breakdown = @organization.price_breakdown.gsub(%r{</?[^>]+?>}, '')
        @organization.application_process = @organization.application_process.gsub(%r{</?[^>]+?>}, '')
        
         
         render :action => "new" 
      end
   end
end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    @organization = Organization.find(params[:id])
    
      if (user_signed_in? && current_user.admin?) || (!current_organization_account.nil? && @organization.id == current_organization_account.organization_id)
        respond_to do |format|
           if @organization.update_attributes(params[:organization])
             if @organization.url[0..3] != "http"
               @organization.url = "http://"+@organization.url
               @organization.save!
             end
             format.html { redirect_to @organization }
             format.json { respond_with_bip(@organization) }
           else
             format.html { render :action => "show" }
             format.json { respond_with_bip(@organization) } 
           end
        end
      else
        redirect_to root_path
      end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end
  
  def programs
    @organization = Organization.find(params[:id])
  end
  
  
      def changeShow
          if (user_signed_in? && current_user.admin?)
            @organization = Organization.find(params[:id])
            if @organization.show
              @organization.show = false
              @organization.save
            else
              @organization.show = true
              @organization.save
            end
              respond_to do |format|
                format.html {redirect_to organizations_path}
              end
          else
            redirect_to root_path
          end
      end
  
private
def admin_pass 
  "4e5d0ed9183ebf2fed541412497e15a30e72f9cb"
end
end
