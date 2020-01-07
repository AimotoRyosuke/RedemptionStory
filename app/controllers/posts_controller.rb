class PostsController < ApplicationController
  before_action :post_params, only: [:create, :update,]

  def index
    @posts = Post.includes(:tags).all.order("id desc").limit(12)
  end
  
  def new
    @post = Post.new
    @post.images.build
    @post.tags.build
  end

  def create
    binding.pry
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      @post.images.build
      @post.tags.build
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if Post.update(update_post_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @likes = Like.where(post_id: params[:id])
    @like = Like.find_by(user_id: current_user.id, post_id: params[:id])
    @comments = Comment.where(post_id: params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.delete
      redirect_to root_path
    else
      render :show
    end
  end

  def rakuten_search
    @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword]).first(10)
    @keyword = params[:keyword]
  end

  private

  def post_params
    params.require(:post).permit(:title, :category_id, :date, :text, tags_attributes:[:name], images_attributes:[:image]).merge(user_id: current_user.id)
  end

  def update_post_params
    params.require(:post).permit(:title, :date, :text, tags_attributes:[:name], images_attributes:[:image, :_destroy, :id]).merge(user_id: current_user.id)
  end
end