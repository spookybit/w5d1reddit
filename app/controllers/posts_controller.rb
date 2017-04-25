class PostsController < ApplicationController
  before_filter :require_sign_in

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    
    if post.save
      redirect_to subs_url #not really, lol
    else
      flash.now[:errors] = post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find_by(params[:id])
    if @post.user_id == current_user.id
      @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = ["Wrong user"]
      render :show
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id = current_user.id
      @post.destroy
    else
      flash.now[:errors] = ["Wrong user"]
      render :show
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
