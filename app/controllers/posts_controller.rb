class PostsController < ApplicationController
def index
  @posts = Post.all
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

def create
  @post = Post.new(post_params)
  @post.user = current_user

  puts @post.inspect

  if @post.save
    flash[:success] = "Successfully created post!"
    redirect_to @post
  else
    render 'new'
  end

end

def destroy
end

def update
  @post = Post.find(params[:id])
  if(@post.update_attributes(post_params))
    flash[:success] = "Successfully updated post information"
    redirect_to @post
  else
    render 'edit'
  end
end

private
def post_params
  params.require(:post).permit(:title, :txt)
end


end
