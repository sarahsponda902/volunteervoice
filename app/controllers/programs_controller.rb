class ProgramsController < ApplicationController

  include ActionView::Helpers::TextHelper
  include ApplicationHelper
  require 'aws/s3'

  before_filter :check_for_admin_or_org_account, :only => [:new, :create, :edit, :update, :destroy]


  # in-alpha-stage search results page (TESTING ONLY)
  # testing facets, can get here from pages/test
  def search_results
    # Sunspot search
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
    # presenter found in presenters/programs/show_presenter.rb
    @presenter = Programs::ShowPresenter.new(params[:id])
    @flag = Flag.new # for the flagging a review form

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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @program }
    end
  end

  # GET /programs/1/edit
  def edit
    @program = Program.find(params[:id])

    # un-textilize textarea text so that it appears normal in text boxes
    @program.description = untextilized(@program.description)
    @program.program_structure = untextilized(@program.program_structure)
    @program.program_cost_breakdown = untextilized(@program.program_cost_breakdown)
    @program.cost_includes = untextilized(@program.cost_includes)
    @program.cost_doesnt_include = untextilized(@program.cost_doesnt_include)
    @program.accommodations = untextilized(@program.accommodations)

    # subjects, group sizes, cost & lengths of time are objects,
    #  so need to get string value for appearance in textboxes
    @subjects = @program.program_subjects.map(&:subject)
    @sizes = @program.program_sizes.map(&:size)
    @costs = @program.program_cost_length_maps.map(&:cost)
    @lengths = @program.program_cost_length_maps.map{|p| "#{p.length_number} #{p.length_name}"}   
  end



  # POST /programs
  # POST /programs.json
  # Admin or Org Account only
  def create
    @program = Program.new(params[:program])

    ## setting @org_id to organization_account's org_id OR the org that was selected at programs/new
    # for use with creating program_subjects, program_sizes, program_cost_length_maps
    if current_organization_account.present?
      @org_id = current_organization_account.organization_id
    elsif (orgs = Organization.where(:name => params[:program][:organization_name])).present?
      @org_id = orgs.first.id
    end

    # creating program_subject, program_size, and program_cost_length_map objects
    # methods in helpers/program_helper.rb
    params[:program][:program_subjects] = make_program_subjects(params[:program][:program_subjects], @org_id)
    params[:program][:program_sizes] = make_program_sizes(params[:program][:program_sizes], @org_id)
    params[:program][:program_cost_length_maps] = make_program_cost_length_maps(params[:costs], params[:lengths], @org_id)


    if @program.save
      # set program_id for cost_length, save and index
      @cost_lengths.each do |f|
        f.program_id = @program.id
        f.save
        f.index!
      end
      # set program_id for subject, save and index
      @subjects.each do |s|
        s.program_id = @program.id
        s.save
      end
      # set program_id for size, save and index
      @sizes.each do |a|
        a.program_id = @program.id
        a.save
      end
      redirect_to @program
    else
      flash[:notice] = flash[:notice].to_a.concat @program.errors.full_messages
      render :action => "new" 
    end
  end



  # PUT /programs/1
  # PUT /programs/1.json
  # Admin and Org Account only
  def update
    @program = Program.find(params[:id])

    # creating new subject, size, and cost-length maps
    params[:program][:program_subjects] = make_program_subjects(params[:program][:program_subjects], @org_id, @program.id)
    params[:program][:program_sizes] = make_program_sizes(params[:program][:program_sizes], @org_id, @program.id)
    params[:program][:program_cost_length_maps] = make_program_cost_length_maps(params[:costs], params[:lengths], @org_id, @program.id)

    # union of current {object}s and new {object}s
    params[:program][:program_subjects] = params[:program][:program_subjects] | @program.program_subjects
    params[:program][:program_sizes] = params[:program][:program_sizes] | @program.program_sizes
    params[:program][:program_cost_length_maps] = params[:program][:program_cost_length_maps] | @program.program_cost_length_maps


    if @program.update_attributes(params[:program])
      respond_to do |format|
        format.html { redirect_to "/programs/#{@program.id}" }
        format.json { head :no_content }
      end
    else
      flash[:notice] = flash[:notice].to_a.concat @program.errors.full_messages
      respond_to do |format|
        format.html { render :action => "edit" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end 
    end

  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program = Program.find(params[:id])    
    @program.destroy

    respond_to do |format|
      # if admin logged in, direct to admin org index
      if current_organization_account.nil?
        format.html { redirect_to "/organizations" }
      else # if org account logged in, direct to org account program index (org account profile)
        format.html { redirect_to "/organization_accounts/profile" }
      end
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

  ## check_for_admin_or_org_account called by before_filter
  def check_for_admin_or_org_account
    if current_organization_account.nil? 
      if (current_user.present? && !(current_user.admin?)) || current_user.nil?
        redirect_to root_path
      end
    end
  end

end
