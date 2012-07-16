require 'test_helper'

class OrganizationAccountsControllerTest < ActionController::TestCase
  setup do
    @organization_account = organization_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organization_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organization_account" do
    assert_difference('OrganizationAccount.count') do
      post :create, organization_account: @organization_account.attributes
    end

    assert_redirected_to organization_account_path(assigns(:organization_account))
  end

  test "should show organization_account" do
    get :show, id: @organization_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organization_account
    assert_response :success
  end

  test "should update organization_account" do
    put :update, id: @organization_account, organization_account: @organization_account.attributes
    assert_redirected_to organization_account_path(assigns(:organization_account))
  end

  test "should destroy organization_account" do
    assert_difference('OrganizationAccount.count', -1) do
      delete :destroy, id: @organization_account
    end

    assert_redirected_to organization_accounts_path
  end
end
