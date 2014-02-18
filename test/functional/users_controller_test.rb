require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup :initialize_user

  def teardown
    @user = nil
  end

  test "should get redirect when getting index for non-signed in user" do
    get :index
    assert_redirected_to "/"
  end

  test "should get index when user signed in" do
    get(:index, user_id: @user.id)
    assert_response :success
  end

  test "should get show" do
    get :show, id: @user.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user.id
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user.id, user_id: @admin.id
    end
    assert_redirected_to users_url
  end

  test "should get update" do
    get :update
    assert_response :success
  end


  private
  def initialize_user
    @user = users(:one)
    @admin = users(:mitchell)
  end

end
