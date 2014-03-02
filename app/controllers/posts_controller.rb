class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :new, :upvote, :unvote, :comment, :commentunvote, :commentupvote, :deletecomment, :edit, :update, :destroy]

  def index
    @posts = Post.all.sort.reverse
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def search
    criteria = params[:search][:search_criteria]
    terms = params[:search][:query_string].split(/[ _]/)
    @posts = search_for(terms, criteria)
    @criteria = criteria
    @query = params[:search][:query_string]
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.category = Category.find(params[:category][:category_id])


    if @post.save
      flash[:success] = "Successfully created post!"
      redirect_to @post
    else
      render 'new'
    end

  end

  def destroy

    Comment.find_all_by_post_id(params[:id]).each do |x|
      x.destroy
    end
    @post = Post.find(params[:id])

    if @post.destroy
      redirect_to posts_index_path
    else
      flash[:error] = "Failed to delete post"
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.category = Category.find(params[:category][:category_id])


    if(@post.update_attributes(post_params))
      flash[:success] = "Successfully updated post information"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def upvote
    @upvote = UpVotePost.new()
    @upvote.user = current_user
    @post = Post.find(params[:id])
    @upvote.post = @post


    if (@upvote.save)
      flash[:success] = "Successfully upvoted this post!"
    else
      flash[:error] = "Failed to upvote post. Try again later."
    end

    redirect_to @post
  end

  def unvote
    @upvote = UpVotePost.find_by_post_id_and_user_id(params[:id],current_user.id)

    @post = Post.find(params[:id])

    if (@upvote.destroy)
      flash[:success] = "Successfully removed your upvote for this post!"
    else
      flash[:error] = "Failed to remove your upvote post. Try again later."
    end
    redirect_to @post
  end

  def deletecomment
    @comment = Comment.find(params[:cid])
    @post = Post.find(params[:id])

    if @comment.destroy
      redirect_to @post
    else
      flash[:error] = "Failed to delete comment"
    end
  end

  def commentupvote
    @upvote = UpVoteComment.new()
    @upvote.user = current_user
    @comment = Comment.find(params[:cid])
    @upvote.comment = @comment

    @post = Post.find(params[:id])

    if (@upvote.save)
      flash[:success] = "Successfully upvoted this comment!"
    else
      flash[:error] = "Failed to upvote comment. Try again later."
    end

    redirect_to @post
  end

  def commentunvote
    @upvote = UpVoteComment.find_by_comment_id_and_user_id(params[:cid],current_user.id)

    @post = Post.find(params[:id])

    if (@upvote.destroy)
      flash[:success] = "Successfully removed your upvote for this comment!"
    else
      flash[:error] = "Failed to remove your upvote comment. Try again later."
    end
    redirect_to @post
  end



  def comment
    @comment = Comment.new(comment_post_params)
    @comment.user = current_user

    @post = Post.find(params[:id])
    @comment.post = @post
    puts @comment.inspect

    if (@comment.save)
      flash[:success] = "Successfully upvoted this post!"
    else
      flash[:error] = "Failed to upvote post. Try again later."
    end

    redirect_to @post
  end

private
  def post_params
    params.require(:post).permit(:title, :txt, :category)
  end
  def comment_post_params
    params.require(:comment).permit(:txt)
  end

  def search_params
    params.require(:search).permit(:query_string, :search_criteria)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to login_url, notice: "Please sign in."
    end
  end

  def search_for(search_terms, search_criteria) #class method to find posts with the given search terms, search_terms is expected to be an array
    posts = Post.all

    if search_criteria.to_s == "post" #match posts containing all key words
      search_terms.each do |term|
        posts.reject! do |post|
          post.txt !~ /#{term}/i && post.title !~ /#{term}/i
        end
      end
      posts
    elsif search_criteria == "category" #match posts in a category with the given name
      full_search = search_terms.join(" ")
      posts.reject! do |post|
        post.category.name.downcase != full_search.downcase
      end
      posts
    elsif search_criteria == "user" #match posts with the given username
      search_terms.each do |term|
        posts.reject! do |post|
          post.user.name !~ /#{term}/i
        end
      end
      posts
    end

  end
end
