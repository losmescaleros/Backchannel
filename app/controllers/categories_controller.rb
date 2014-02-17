class CategoriesController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create]
  before_filter :admin_user, only: [:edit, :update, :destroy, :approve]

  def index
    @categories = Category.all.sort
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.approved = false
    if @category.save
      flash[:success] = "Successfully added your category proposal for review."
      redirect_to @category
    else
      flash[:error] = "Failed to create new category!"
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Successfully updated category."
      redirect_to @category
    else
      flash[:error] = "Failed to update category!"
      render 'edit'
    end
  end

  def approve
    @category = Category.find(params[:id])
    @category.approved = true
    if @category.save
      flash[:success] = "Successfully approved category for use."

    else
      flash[:error] = "Failed to approve category!"

    end
    redirect_to categories_url
  end

  def destroy
    category = Category.find(params[:id])
    if category.destroy
      flash[:success] = "Successfully removed category."
      redirect_to categories_url
    else
      flash[:error] = "Failed to remove category!"
      redirect_to categories_url
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def signed_in_user
    redirect_to login_url, notice: "Log in to continue" unless signed_in?
  end

  def admin_user
    redirect_to categories_index_url unless current_user.admin?
  end
end
