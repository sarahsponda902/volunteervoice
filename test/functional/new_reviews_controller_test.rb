require 'test_helper'

class NewReviewsControllerTest < ActionController::TestCase
  setup do
    @new_review = new_reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:new_reviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create new_review" do
    assert_difference('NewReview.count') do
      post :create, new_review: @new_review.attributes
    end

    assert_redirected_to new_review_path(assigns(:new_review))
  end

  test "should show new_review" do
    get :show, id: @new_review
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @new_review
    assert_response :success
  end

  test "should update new_review" do
    put :update, id: @new_review, new_review: @new_review.attributes
    assert_redirected_to new_review_path(assigns(:new_review))
  end

  test "should destroy new_review" do
    assert_difference('NewReview.count', -1) do
      delete :destroy, id: @new_review
    end

    assert_redirected_to new_reviews_path
  end
end
