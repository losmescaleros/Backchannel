class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_level = 1

    if @user.save
      sign_in @user
      flash[:success] = "Successfully created user!"
      redirect_to @user
    else
      render 'new'
    end

  end

  def destroy
  end

  def update
    @user = User.find(params[:id])
    if(@user.update_attributes(user_params))
      flash[:success] = "Successfully updated user information"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation, :email, :name)
    end

    def signed_in_user
      redirect_to login_url, notice: "Log in to continue" unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end