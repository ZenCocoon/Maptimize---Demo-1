require 'test_helper'

class BusinessesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:businesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business" do
    assert_difference('Business.count') do
      post :create, :business => { }
    end

    assert_redirected_to business_path(assigns(:business))
  end

  test "should show business" do
    get :show, :id => businesses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => businesses(:one).to_param
    assert_response :success
  end

  test "should update business" do
    put :update, :id => businesses(:one).to_param, :business => { }
    assert_redirected_to business_path(assigns(:business))
  end

  test "should destroy business" do
    assert_difference('Business.count', -1) do
      delete :destroy, :id => businesses(:one).to_param
    end

    assert_redirected_to businesses_path
  end
end
