class PostsController < ApplicationController
  before_action :post_params, only: [:create, :update,]

  def index
    @posts = Post.all.order("id desc").limit(12)
  end
  
  def new
    @post = Post.new
    @post.images.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if Post.update
      redirect_to root_path
    else
      render edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.delete
      redirect_to root_path
    else
      render show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :date, :text, images_attributes:[:image]).merge(user_id: current_user.id)
  end

end