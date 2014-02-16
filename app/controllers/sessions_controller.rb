class SessionsController < ApplicationController
  def new
  end

  def create
    puts "Attempting to log in #{params[:session][:email]}"
    user = User.find_by_email(params[:session][:email].downcase)
    if(user && user.authenticate(params[:session][:password]))
      # Direct to some page
      sign_in user
      redirect_to user
    else
      # Show error, redirect to login form
      flash.now[:error] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
