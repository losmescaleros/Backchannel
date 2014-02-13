require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "cannot save user with empty fields" do
    user = User.new
    assert !(user.save), "User fields should not be empty or null"
  end

  test "can use password_confirmation when creating user" do

      @user = User.new(email: "example@email.com",
                       name: "name",
                       password: "password",
                       password_confirmation: "password")

    assert @user.respond_to?(:password_confirmation)

  end
end
