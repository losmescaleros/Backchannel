class AccountController < ApplicationController
  def register
    @user = User.new
  end



  def login
    puts login_params
    @user = User.authenticate(login_params)
    if @user != nil
      reset_session
      session[:email] = @user.email
      session[:name] = @user.name
      session[:user_level] = @user.user_level
      format.html { redirect_to @index, notice: 'Successfully logged in!' } #I'm honestly not sure how these redirect_to's work but the intent should be clear
      format.json { render action: 'show', status: :logged_in, location: @index }
    end
  end

  def logout
    reset_session
    format.html { redirect_to @index, notice: 'Successfully logged out!' }
    format.json { render action: 'show', status: :logged_out, location: @index }
  end

  def create
    puts user_params
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @login, notice: 'Successfully registered!' }
        format.json { render action: 'show', status: :created, location: @login }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_params
    params.require(:email).require(:name).require(:password)
  end

  def login_params
    params.require(:email).require(:password)
  end
end
