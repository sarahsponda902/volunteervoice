class ProgramsController < ApplicationController

  include ActionView::Helpers::TextHelper
  include ApplicationHelper
  require 'aws/s3'

  before_filter :check_for_admin_or_org_account, :only => [:new, :create, :edit, :update, :destroy]
  respond_to :html, :json

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
    respond_with(@presenter.this_program)
  end

  # GET /programs/new
  # GET /programs/new.json
  def new
    @program = Program.new
    @costs = []
    respond_with(@program)
  end

  # GET /programs/1/edit
  def edit
    @program = Program.find(params[:id])
    ["description", "program_structure", "program_cost_breakdown", "cost_includes", "cost_doesnt_include",
      "accommodations"].each do |attrib|
      @program.assign_attributes({attrib.to_sym => untextilized(@program.send(attrib)}))
    end

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
    [:program_subjects, :program_sizes].each do |attrib|
      params[:program][attrib] = ApplicationHelper.send("make_#{attrib.to_s}", params[:program][attrib], @org_id, @progr)
    end
    params[:program][:program_cost_length_maps] = make_program_cost_length_maps(params[:costs], params[:lengths], @org_id, @program.id)
    
    if @program.save
      [@cost_lengths, @subjects, @sizes].each do |arr|
        arr.each do |inst|
          inst.program_id = @program.id
          inst.save
          inst.index! if arr == @cost_lengths
        end
      end
    end
    respond_with(@program)
  end



  # PUT /programs/1
  # PUT /programs/1.json
  # Admin and Org Account only
  def update
    @program = Program.find(params[:id])
    [:program_subjects, :program_sizes].each do |attrib|
      params[:program][attrib] = ApplicationHelper.send("make_#{attrib.to_s}", params[:program][attrib], @org_id, @progr)
    end
    params[:program][:program_cost_length_maps] = make_program_cost_length_maps(params[:costs], params[:lengths], @org_id, @program.id)
    
    # union of current {object}s and new {object}s
    [:program_subjects, :program_sizes, :program_cost_length_maps].each do |attrib|
      params[:program][attrib] = params[:program][attrib] | @program.send(attrib.to_s)
    end
    
    @program.update_attributes(params[:program])
    respond_with(@program)
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program = Program.find(params[:id])    
    @program.destroy

    respond_with(@program) do
      if current_organization_account.nil?
        redirect_to organizations_path
      else
        redirect_to "/organization_accounts/profile"
      end
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
     unless (user_signed_in? && current_user.admin?) || current_organization_account.present?
       redirect_to root_path
     end
   end

end
