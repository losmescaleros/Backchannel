# Category controller class which defines controller methods for the 'category' route
class CategoriesController < ApplicationController
  # Only allow signed in users to access 'new' and 'create' methods
  before_filter :signed_in_user, only: [:new, :create]
  # Only admins are allowed to edit, update, destroy, or approve a category
  before_filter :admin_user, only: [:edit, :update, :destroy, :approve]

  # List of all categories
  def index
    @categories = Category.all.sort
  end

  # The new category page
  def new
    @category = Category.new
  end

  # The POST action to create a new category
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

  # The GET action to begin editing an existing category
  def edit
    @category = Category.find(params[:id])
  end

  # The POST action to update the category after saving an edit
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      # Successfully updated the category
      flash[:success] = "Successfully updated category."
      redirect_to @category
    else
      # There was an error updating the category. Show error and return to the 'edit' page
      flash[:error] = "Failed to update category!"
      render 'edit'
    end
  end

  # Approve a category by specifying its ID
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

  # Delete a category
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

  # Show the details for a category by its ID
  def show
    @category = Category.find(params[:id])
  end

  private
  
  # Filter the params passed to the controller so that we only permit category params
  def category_params
    params.require(:category).permit(:name)
  end

  # If the user is not signed in, redirect to login
  def signed_in_user
    redirect_to login_url, notice: "Log in to continue" unless signed_in?
  end

  # If the user does not have the admin role, redirect to the category index
  def admin_user
    redirect_to categories_index_url unless current_user.admin?
  end
end
