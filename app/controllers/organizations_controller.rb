class OrganizationsController < ApplicationController
  require 'aws/s3'
  include ActionView::Helpers::TextHelper

  before_filter :check_for_admin, :only => [:index, :crop, :edit, :create, :changeShow, :new]
  before_filter :check_for_admin_or_org_account, :only => [:update]


  # can get here from home page by clicking "# organizations so far" on home page
  # shows all organizations we have so far, sorted
  # default sort is highest rated -> lowest rated
  def show_all
    @sort_by = params[:sort_by]
    if @sort_by.nil? || @sort_by == "rating_high"
      @organizations = Organization.all.sort_by(&:overall).reverse
    elsif @sort_by == "rating_low"
      @organizations = Organization.all.sort_by(&:overall)
    elsif @sort_by == "review_recent"
      @organizations = Organization.all.sort_by(&:latest_review_time).reverse
    elsif @sort_by == "profiled_recent"
      @organizations = Organization.all.sort_by(&:created_at).reverse
    elsif @sort_by == "alphabetical_az"
      @organizations = Organization.all.sort_by(&:name)
    else # if sort_by == 'alphabetical_za'
      @organizations = Organization.all.sort_by(&:name).reverse
    end

  end



  # GET /organizations
  # GET /organizations.json
  # Admin only
  def index
    @organizations = Organization.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizations }
    end
  end



  # Admin only crop organization's image page
  def crop
    @organization = Organization.find(params[:id])
  end



  # GET /organizations/1
  # GET /organizations/1.json
  def show 
    # presenter found in presenters/organizations/show_presenter.rb
    @presenter = Organizations::ShowPresenter.new(params[:id])
    @flag = Flag.new # for the flagging a review form

    # for the in-place editing (mainly for organization accounts)
    #  Only Admin & Org Accounts can edit
    if (user_signed_in? && current_user.admin?) || (current_organization_account.present? && current_organization_account.organization_id == @presenter.this_organization.id)
      @can_edit = true
    else
      @can_edit = false
    end

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
    @organization = Organization.find(params[:id])

    # Un-textilizing the text fields so they don't appear with <p>, etc.
    @organization.description = untextilized(@organization.description)
    @organization.headquarters_location = untextilized(@organization.headquarters_location)
    @organization.good_to_know = untextilized(@organization.good_to_know)
    @organization.training_resources = untextilized(@organization.training_resources)
    @organization.misson = untextilized(@organization.misson)
    @organization.program_costs_includes = untextilized(@organization.program_costs_includes)
    @organization.program_costs_doesnt_include = untextilized(@organization.program_costs_doesnt_include)
    @organization.price_breakdown = untextilized(@organization.price_breakdown)
    @organization.application_process = untextilized(@organization.application_process)


  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])

    if @organization.save
      # if admin opted to invite organization_account on create, then invite them
      if @organization.will_invite && @organization.invite_email.present?
        OrganizationAccount.invite!(:email => @organization.invite_email, :organization_id => @organization.id, :admin_pass => admin_pass)
      end
      # crop the new image to be square
      redirect_to "/organizations/#{@organization.id}/crop"
    else
      render :action => "new" 
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    @organization = Organization.find(params[:id])

    # if current org account is owner of the organization they are viewing
    if (!current_organization_account.nil? && @organization.id == current_organization_account.organization_id)
      respond_to do |format|
        if @organization.update_attributes(params[:organization])
          if @organization.crops
            format.html { redirect_to "/organizations/#{@organization.id}/crop" }
            format.json { respond_with_bip(@organization) } # best_in_place syntax (in-place editing)
          else
            format.html { redirect_to @organization }
            format.json { respond_with_bip(@organization) }
          end
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

  # page that shows all organization's programs
  def programs
    @organization = Organization.find(params[:id])
  end

  # method called to change whether or not an organization can be shown on the home page
  # Admin only
  def changeShow
    @organization = Organization.find(params[:id])
    if @organization.show
      @organization.show = false
    else
      @organization.show = true
    end
    @organization.save
    respond_to do |format|
      format.html {redirect_to organizations_path}
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
      Rails.logger.info("Not org or admin")
      redirect_to root_path
    end
  end
end
