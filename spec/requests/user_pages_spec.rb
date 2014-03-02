require 'spec_helper'

describe "User pages" do

  subject{page}

  describe "user profile page" do
    let(:user){FactoryGirl.create(:user)}
    before{visit user_path(user)}

    it {should have_title("Backchannel | #{user.name}")}
    it {should have_content("Profile")}
  end

  describe "user registration" do
    before {visit register_path}
    # Let 'submit' refer to the Register button on the page
    let(:submit){"Register"}

    # Page content should include 'Register'
    it {should have_content("Register")}
    # Page title should be 'Backchannel | Register'
    it {should have_title("Backchannel | Register")}

    # A new user registering with invalid credentials should not
    # change our Users count
    describe "with invalid credentials" do
      it "should not create a new user" do
        expect{click_button submit}.not_to change(User, :count)
      end

      # An error message containing 'error' should display after invalid registration
      describe "after submission" do
        before {click_button submit}

        it {should have_title("Backchannel | Register")}
        it {should have_content('error')}
      end
    end

    # A new user registering with valid credentials should increase
    # Users count by 1
    describe "with valid credentials" do
      before do
        fill_in "Email", with: "example@example.com"
        fill_in "Name", with: "Example"
        fill_in "Password", with: "example"
        fill_in "Confirm Password", with: "example"
      end

      it "should create a new user" do
        expect{click_button submit}.to change(User, :count).by(1)
      end


      # After successful submission, we should be directed to the Example user's
      # profile page and have a message about successful registration
      describe "after submission" do
        before{click_button submit}
        let(:user){User.find_by_email("example@example.com")}
        it {should have_link("Sign out")}
        it {should_not have_link("Sign in")}
        it {should have_title("Backchannel | #{user.name}")}
        it {should have_content("Successfully created user!")}
      end
    end

  end

end
