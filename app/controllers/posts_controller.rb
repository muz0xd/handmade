class PostsController < ApplicationController

  before_action :authorize, except: [:index, :show]

  def index
    @posts = Post.order("created_at DESC").page params[:page]
    head 404 if @posts.blank? and params[:page].present?
  end

  def new
    @post = Post.new
  end

  def create
    Post.create post_params
    redirect_to posts_path
  end

  def show
    @post = Post.find params[:id]
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    post = Post.find params[:id]
    post.update_attributes post_params
    redirect_to posts_path
  end

  def destroy
    post = Post.find params[:id]
    post.destroy
    redirect_to posts_path
  end

  private

  def authorize
    redirect_to new_admin_session_path unless admin_signed_in?
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
