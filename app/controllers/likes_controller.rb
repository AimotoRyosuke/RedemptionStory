class LikesController < ApplicationController
  before_action :like_params, only: :create

  def create
    @like = Like.create(like_params)
    @likes = Like.where(post_id: params[:post_id])
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id)
    @like.destroy
    @likes = Like.where(post_id: params[:post_id])
  end

  private

  def like_params
    params.permit(:post_id).merge(user_id: current_user.id)
  end

end
