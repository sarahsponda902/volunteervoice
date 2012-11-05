class OrganizationAccountsController < ApplicationController
  before_filter :check_for_admin, :only => [:resend_invitation, :send_new_invitation, :index, :destroy]
  before_filter :authenticate_organization_account!, :only => [:profile]
  before_filter :check_for_admin_or_org_account, :only => [:update, :edit]

  ## resends devise_invitable invitation, called in #index
  # Admin only
  def resend_invitation
    @user = OrganizationAccount.find(params[:user_id])
    @user.invite!
    redirect_to organization_accounts_path
  end


  # Invite a new organization, called in #index
  # Admin only
  def send_new_invitation
    @organization_id = Organization.where(:name => params[:organization_name]).first.id
    OrganizationAccount.invite!(:email => params[:email], :organization_id => @organization_id, :nonprofit => params[:nonprofit])
    redirect_to "/organization_accounts"
  end

  # Request an Organization Account page
  # Can only get here if popup form is invalidated
  def new_request
    @contact = Contact.new

    respond_to do |format|
      format.html # new_request.html.erb
      format.json { render json: @contact }
    end
  end

  def thank_you_request
  end

  # GET /organization_accounts
  # GET /organization_accounts.json
  # Admin only
  def index
    @organization_accounts = OrganizationAccount.all.sort_by(&:organization_name).reverse

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organization_accounts }
    end
  end

  # GET /organization_accounts/1
  # GET /organization_accounts/1.json
  def profile
    @organization_account = current_organization_account
    @organization = Organization.find(@organization_account.organization_id)

    ## Get total overall score for org
    ##   add up all org's overall scores and divide it by # reviews 
    @overall = 0
    @reviews = Review.where(:organization_id => @organization.id)
    if !(@reviews.count == 0)
      @reviews.each do |f|
        @overall = @overall + f.overall
      end
      @overall = @overall / @reviews.count
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization_account }
    end
  end

  # GET /organization_accounts/new
  # GET /organization_accounts/new.json
  def new
    @organization_account = OrganizationAccount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization_account }
    end
  end

  # PUT /organization_accounts/1
  # PUT /organization_accounts/1.json
  # Admin or Org Account only
  def update
    @organization_account = OrganizationAccount.find(params[:id])

    respond_to do |format|
      if @organization_account.update_attributes(params[:organization_account])
        format.html { redirect_to @organization_account, notice: 'Organization account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organization_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organization_accounts/1
  # DELETE /organization_accounts/1.json
  # Admin only
  def destroy
    @organization_account = OrganizationAccount.find(params[:id])
    @organization_account.destroy

    respond_to do |format|
      format.html { redirect_to organization_accounts_url }
      format.json { head :no_content }
    end
  end


  # link to this method is put in all madmimi newsletters
  # will unsubscribe or subscribe a org_account depending on their current settings
  def change_subscription
    @organization_account = OrganizationAccount.find(params[:id])
    @organization_account.notify = !@organization_account.notify
    @organization_account.save
    respond_to do |format|
      format.html { render :action => "successful_unsubscribe" }
      format.json { head :no_content }
    end
  end

  ## page that the org_account is sent to when they have successfully unsubscribed
  def successful_unsubscribe
  end


  # Org Account or Admin only edit page
  # Org Account is only sent here if they mess up on the popup
  def edit
    @organization_account = OrganizationAccount.find(params[:id])
    respond_to do |format|
      format.html
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
    unless current_organization_account.present? || (user_signed_in? && current_user.admin?)
      redirect_to root_path
    end
  end

end
