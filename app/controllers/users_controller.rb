class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:index, :destroy, :promote]
  before_filter :super_admin_user, only: [:demote]

  def index
    @users = User.all.sort
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
    user = User.find(params[:id])
    #
    if(user.super_admin?)
      flash[:error] = "Cannot remove super administrator!"
      redirect_to users_url
    end
    user.destroy
    flash[:success] = "User successfully removed."
    redirect_to users_url
  end

  def update
    @user = User.find(params[:id])
    if(@user.update_attributes(user_params))
      flash[:success] = "Successfully updated user information."
      redirect_to @user
    else
      flash[:error] = "Failed to update profile information!"
      render 'edit'
    end
  end

  def promote
    @user = User.find(params[:id])
    if(!@user.admin? && @user.promote)

      flash[:success] = "Successfully promoted user."

    else
      flash[:error] = "Failed to promote user to administrator!"
    end

    redirect_to users_url
  end

  def demote
    @user = User.find(params[:id])
    if(current_user.super_admin? && @user.admin? && !@user.super_admin? && @user.demote)

      flash[:success] = "Successfully demoted user."

    else
      flash[:error] = "Failed to demote user from administrator!"
    end

    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation, :email, :name)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to login_url, notice: "Log in to continue"
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless (!current_user.nil? && current_user?(@user))
    end

    def admin_user
      redirect_to root_url unless (!current_user.nil? && current_user.admin?)
    end

    def super_admin_user
      redirect_to root_url unless (!current_user.nil? && current_user.super_admin?)
    end
end
