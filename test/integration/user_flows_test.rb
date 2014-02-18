require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users

  test "guest usage" do
    https!
    get "/login"
    assert_response :success

    get "/about"
    assert_response :success

    get "/categories"
    assert_response :success

    get "/posts"
    assert_response :success

    get "/posts/new"
    assert_response 302

    get "/posts"
    assert_response :success

    get "/users/new"
    assert_response :success

  end


end