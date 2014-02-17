class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_post_params)
    @comment.user = current_user
    @post = Post.find(params[:id])
    @comment.post = @post

    if @comment.save
      flash[:success] = "Successfully created comment!"

      redirect_to @post
    else
      render 'new'
    end

  end

  def destroy
    @post = Post.find(params[:id])

    if (@comment.destroy)
      redirect_to @post
    else
      flash[:error] = "Failed to delete comment"
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if(@comment.update_attributes(comment_post_params))
      flash[:success] = "Successfully updated comment information"

      @post = Post.find(params[:post_id])

      redirect_to @post
    else
      render 'edit'
    end
  end



  private
  def comment_post_params
    params.require(:comment).permit(:txt)
  end

end
