class OrganizationAccountsController < ApplicationController
  # GET /organization_accounts
  # GET /organization_accounts.json
  def index
    @organization_accounts = OrganizationAccount.all
    
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
  def show
    @organization_account = OrganizationAccount.find(params[:id])

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
end
