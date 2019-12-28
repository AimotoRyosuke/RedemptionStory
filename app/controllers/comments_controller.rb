class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params)
  end

  def destroy
    @comment = Comment.find(comment.id)
    @comment.destroy
  end

  private

  def comment_params
    params.permit(:text, :post_id).merge(user_id: current_user.id)
  end
end
