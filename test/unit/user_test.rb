require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "cannot save user with empty fields" do
    user = User.new
    assert !(user.save), "User with empty fields can be saved"
  end

  test "does not validate without email presence" do
    user = User.new(name: "name",
                    password: "password",
                    password_confirmation: "password")
    assert !(user.valid?), "User without email validated"
  end

  test "does not validate without name presence" do
    user = User.new(email: "example@email.com",
                    password: "password",
                    password_confirmation: "password")
    assert !(user.valid?), "User without name validated"
  end

  test "does not validate without password presence" do
    user = User.new(name: "name",
                    email: "example@email.com",
                    password_confirmation: "password")
    assert !(user.valid?), "User without password validated"
  end

  test "can use password_confirmation when creating user" do

      @user = User.new(email: "example@email.com",
                       name: "name",
                       password: "password",
                       password_confirmation: "password")

    assert @user.respond_to?(:password_confirmation), "Does not respond to password_confirmation"
  end

  test "user email address with spaces do not validate" do
    user = User.first
    user.email = "invalid @email.com"
    assert !(user.valid?), "User email with spaces validates"
  end

  test "user email address with invalid characters do not validate" do
    user = User.first
    user.email = "invalid!@email.com"
    assert !(user.valid?), "User email with '!' validates"
  end

  test "user email address without @ does not validate" do
    user = User.first
    user.email = "invalidemail.com"
    assert !(user.valid?), "User email without @ validates"
  end

  test "user email address without .com does not validate" do
    user = User.first
    user.email = "invalid @email"
    assert !(user.valid?), "User email without .com validates"
  end

  test "user email address without portion before @ does not validate" do
    user = User.first
    user.email = "@email.com"
    assert !(user.valid?), "User email without portion before @ validates"
  end

  test "boolean admin function returns correct value" do
    user = User.first
    user.user_level = 1
    assert !(user.admin?), "regular user reported as admin"

    user.user_level = User::ADMIN_USER_LEVEL
    assert (user.admin?), "admin user not reported as admin"
  end

  test "boolean super_admin function returns correct value" do
    user = User.first
    user.user_level = User::ADMIN_USER_LEVEL
    assert !(user.super_admin?), "admin user reported as super admin"

    user.user_level = 1
    assert !(user.super_admin?), "regular user reported as super admin"

    user.user_level = User::SUPER_ADMIN_USER_LEVEL
    assert (user.super_admin?), "super admin not reported as super admin"
  end

  test "users sort correctly sorts by name" do
    user1 = User.new(name: "Zed")
    user2 = User.new(name: "Abigail")
    users = [user1, user2]
    users.sort!
    assert (users[0].name == "Abigail"), "Sort did not arrange users by name alphabetically"
  end

  test "promote returns nil if user is already an admin" do
    user = User.new(user_level: User::ADMIN_USER_LEVEL)
    assert !(user.promote), "Promoting an admin did not return nil"

    user.user_level = User::SUPER_ADMIN_USER_LEVEL
    assert !(user.promote), "Promoting a super_admin did not return nil"
  end

  test "promote returns true if user is not an admin" do
    user = User.new(email: "some@email.com",
                    user_level: User::REGULAR_USER_LEVEL)
    assert (user.promote), "Promoting a non-admin user did not return true"
  end

  test "demote returns nil if user is already a regular user" do
    user = User.new(user_level: User::REGULAR_USER_LEVEL)
    assert !(user.demote), "Demoting a regular user did not return nil"
  end

  test "demote returns true if user is an admin and not a super admin" do
    user = User.new(email: "some@email.com",
                    user_level: User::ADMIN_USER_LEVEL)
    assert (user.demote), "Demoting an admin user did not return true"

    user.user_level = User::SUPER_ADMIN_USER_LEVEL
    assert !(user.demote), "Demoting a super_admin did not return nil"
  end

end
