require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "cannot save user with empty fields" do
    user = User.new
    assert !(user.save), "User fields should not be empty or null"
  end
end
