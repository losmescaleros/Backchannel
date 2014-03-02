def sign_in(user, options={})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, remember_token)
  else
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Submit"
  end
end