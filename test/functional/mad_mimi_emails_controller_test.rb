require 'test_helper'

class MadMimiEmailsControllerTest < ActionController::TestCase
  setup do
    @mad_mimi_email = mad_mimi_emails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mad_mimi_emails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mad_mimi_email" do
    assert_difference('MadMimiEmail.count') do
      post :create, mad_mimi_email: @mad_mimi_email.attributes
    end

    assert_redirected_to mad_mimi_email_path(assigns(:mad_mimi_email))
  end

  test "should show mad_mimi_email" do
    get :show, id: @mad_mimi_email
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mad_mimi_email
    assert_response :success
  end

  test "should update mad_mimi_email" do
    put :update, id: @mad_mimi_email, mad_mimi_email: @mad_mimi_email.attributes
    assert_redirected_to mad_mimi_email_path(assigns(:mad_mimi_email))
  end

  test "should destroy mad_mimi_email" do
    assert_difference('MadMimiEmail.count', -1) do
      delete :destroy, id: @mad_mimi_email
    end

    assert_redirected_to mad_mimi_emails_path
  end
end
