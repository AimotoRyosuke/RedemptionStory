class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :post_params, only: [:create]
  before_action :update_post_params, only: [:update]

  def index
    @posts = Post.includes(:tags).all.order("id desc").limit(12)
  end
  
  def new
    @post = Post.new
    @post.images.build
    @post.tags.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
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
    @post = Post.find(params[:id])
    if @post.update(update_post_params)
      redirect_to post_path
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @likes = Like.where(post_id: params[:id])
    @comments = Comment.where(post_id: params[:id])
    if user_signed_in?
      @like = Like.find_by(user_id: current_user.id, post_id: params[:id])
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def search
    if params[:search].present?
      @posts = Post.with_tag.search(*search_data).distinct.order("updated_at desc")
    else
    @posts = Post.all.order("id desc")
    end
  end

  def rakuten_search
    @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword]).first(15)
    @keyword = params[:keyword]
  end

  private

  def post_params
    params.require(:post).permit(:title, :category_id, :date, :text, tags_attributes:[:name, :_destroy, :id], images_attributes:[:image, :remote_image_url]).merge({user_id: current_user.id, tag_ids: params[:tag_ids]})
  end

  def update_post_params
    params.require(:post).permit(:title, :date, :text, tags_attributes:[:name, :_destroy, :id], images_attributes:[:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def search_data
    params.require(:search).permit(:keyword, :category_id, :date_start, :date_end, "month_start(2i)", "month_end(2i)", :gender, :age_start, :age_end).values
  end
end