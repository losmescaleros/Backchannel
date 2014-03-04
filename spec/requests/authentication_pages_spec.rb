require 'spec_helper'

describe "Authentication pages" do
  subject { page }

  describe "log in" do
    before { visit login_path}
    let(:log_in){"Submit"}

    # Logging in with invalid information should show an error message
    # and return the log in page again
    describe "with invalid credentials" do

      before {click_button log_in}

      it { should have_title("Backchannel | Log in")}
      it { should have_content("Invalid email or password")}
    end

    # Logging in with valid information should direct to the user's profile
    describe "with valid credentials" do
      let(:user){FactoryGirl.create(:user)}
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button log_in
      end

      it {should have_title("Backchannel | #{user.name}")}
      it {should have_link("Sign out", href: logout_path)}
      it {should have_link("Edit Profile", href: edit_user_path(user))}
      it {should_not have_link("Sign in", href: login_path)}

      describe "followed by sign out" do
        before{ click_link "Sign out"}
        it{should have_link "Sign in"}
      end
    end
  end

  describe "authorization" do
    let(:user){FactoryGirl.create(:user)}
    describe "for non-signed in users" do
      describe "in the Users controller" do
        describe "visiting the users index" do
          before {get users_path}
          specify{ expect(response).to redirect_to(root_url)}
        end
      end

      describe "in the Posts controller" do
        before do
          visit new_post_path
        end
        it{should have_title("Backchannel | Log in")}
        describe "after signing in" do
          before{sign_in user}
          it "should render the new post page" do
            expect(page).to have_content("New Post")
            expect(page).to have_title("New Post")
          end
        end

      end
    end

    describe "for non-admin users" do
      let(:non_admin){FactoryGirl.create(:user)}
      before {sign_in non_admin, no_capybara: true}
      describe "in the Users controller" do
        describe "submitting a GET request to the Users#index action" do
          before{get users_path}
          specify { expect(response).to redirect_to(root_url) }
        end

        describe "submitting a DELETE request to the Users#destroy action" do
          before { delete user_path(user) }
          specify { expect(response).to redirect_to(login_url) }
        end
      end
    end

    describe
  end
end
