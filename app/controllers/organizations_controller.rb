class OrganizationsController < ApplicationController
  require 'aws/s3'
  include ActionView::Helpers::TextHelper

  before_filter :check_for_admin, :only => [:index, :crop, :edit, :create, :changeShow, :new]
  before_filter :check_for_admin_or_org_account, :only => [:update]
  respond_to :html, :json, :xml

  def show_all
    @organizations = Organization.order(params[:sort_by] || "overall desc")
    respond_with(@organizations)
  end



  # GET /organizations
  # GET /organizations.json
  # Admin only
  def index
    @organizations = Organization.all
    respond_with(@organizations)
  end



  # Admin only crop organization's image page
  def crop
    @organization = Organization.find(params[:id])
    respond_with(@organization)
  end



  # GET /organizations/1
  # GET /organizations/1.json
  def show 
    # presenter found in presenters/organizations/show_presenter.rb
    @presenter = Organizations::ShowPresenter.new(params[:id])
    @flag = Flag.new # for the flagging a review form

    @can_edit = (user_signed_in? && current_user.admin?) || (current_organization_account.present? && current_organization_account.organization_id == @presenter.this_organization.id)
    respond_with(@presenter.this_organization)
  end


  # GET /organizations/new
  # GET /organizations/new.json
  def new
    @organization = Organization.new
    respond_with(@organization)
  end

  # GET /organizations/1/edit
  def edit
    @organization = Organization.find(params[:id])
    ["description", "headquarters_location", "good_to_know", "training_resources", "misson", 
      "program_costs_includes", "program_costs_doesnt_include", "price_breakdown", 
      "application_process"].each do |param|
      @organization.assign_attributes({param.to_sym => untextilized(@organization.send(param))})
    end
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])
    @organization.reviewed_at = REVIEWED_AT_OLD
    respond_with(@organization) do
      if @organization.save
        if @organization.will_invite && @organization.invite_email.present?
          OrganizationAccount.invite!(:email => @organization.invite_email, :organization_id => @organization.id, :admin_pass => admin_pass)
        end
        redirect_to "/organizations/#{@organization.id}/crop"
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      format.json { respond_with_bip(@organization) }
      if (upd = @organization.update_attributes(params[:organization])) && @organization.crops
        format.html { redirect_to "/organizations/#{@organization.id}/crop" }
      elsif upd
        format.html { redirect_to @organization }
      else
        format.html { render :action => "show" } 
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    respond_with(@organization)
  end

  # page that shows all organization's programs
  def programs
    @organization = Organization.find(params[:id])
  end

  # method called to change whether or not an organization can be shown on the home page
  # Admin only
  def changeShow
    @organization = Organization.find(params[:id])
    @organization.show = !@organization.show
    @organization.save
    respond_with(@organization)
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
    unless (user_signed_in? && current_user.admin?) || (current_organization_account.present? &&
      current_organization_account.id == params[:id])
      redirect_to root_path
    end
  end
end
