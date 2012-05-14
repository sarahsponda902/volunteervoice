require 'test_helper'

class SimpleMessagesControllerTest < ActionController::TestCase
  setup do
    @simple_message = simple_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:simple_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create simple_message" do
    assert_difference('SimpleMessage.count') do
      post :create, :simple_message => @simple_message.attributes
    end

    assert_redirected_to simple_message_path(assigns(:simple_message))
  end

  test "should show simple_message" do
    get :show, :id => @simple_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @simple_message
    assert_response :success
  end

  test "should update simple_message" do
    put :update, :id => @simple_message, :simple_message => @simple_message.attributes
    assert_redirected_to simple_message_path(assigns(:simple_message))
  end

  test "should destroy simple_message" do
    assert_difference('SimpleMessage.count', -1) do
      delete :destroy, :id => @simple_message
    end

    assert_redirected_to simple_messages_path
  end
end
