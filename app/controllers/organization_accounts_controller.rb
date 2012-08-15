class OrganizationAccountsController < ApplicationController
  
  def resend_invitation
    if user_signed_in? && current_user.admin?
      @user = OrganizationAccount.find(params[:user_id])
      @user.invite!
      redirect_to "/organization_accounts"
    else
      redirect_to root_path
    end
  end
  
  def send_new_invitation
    if user_signed_in? && current_user.admin?
      @organization_id = Organization.where(:name => params[:organization_name]).first.id
      @email = params[:email]
      @nonprofit = params[:nonprofit]
      OrganizationAccount.invite!(:email => @email, :organization_id => @organization_id, :nonprofit => @nonprofit)
      redirect_to "/organization_accounts"
    else
      redirect_to root_path
    end
  end
  
  
  def new_request
    @contact = Contact.new
    
    respond_to do |format|
      format.html # new_request.html.erb
      format.json { render json: @contact }
    end
  end
  
  # GET /organization_accounts
  # GET /organization_accounts.json
  def index
    @organization_accounts = OrganizationAccount.all.sort_by(&:organization_name).reverse
    
    if user_signed_in? && current_user.admin?
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @organization_accounts }
      end
    else
      redirect_to root_path
    end
  end

  # GET /organization_accounts/1
  # GET /organization_accounts/1.json
  def profile
    
    if organization_account_signed_in?
      @organization_account = current_organization_account
      @organization = Organization.find(@organization_account.organization_id)
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
    else
      redirect_to root_path
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
  def destroy
    @organization_account = OrganizationAccount.find(params[:id])
    @organization_account.destroy

    respond_to do |format|
      format.html { redirect_to organization_accounts_url }
      format.json { head :no_content }
    end
  end
  
  def change_subscription
    @organization_account = OrganizationAccount.find(params[:id])
    @organization_account.notify = !@organization_account.notify unless @organization_account.notify.nil?
    @organization_account.save
    respond_to do |format|
      format.html {render :action => "successful_unsubscribe"}
      format.json {head :no_content}
    end
  end
  
  
  def successful_unsubscribe
  end
  
end
