require 'spec_helper'

describe "Static pages" do

  # Define the subject to be 'page', so that should methods refer
  # to page
  subject {page}

  # Home page is the root path.
  describe "Home page" do

    before {visit root_path}

    it {should have_content('Backchannel Application')}
    it {should have_title("Backchannel | Home")}
  end
end
