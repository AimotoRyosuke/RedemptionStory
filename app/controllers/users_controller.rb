class UsersController < ApplicationController

  def signup_menu
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.stop_following(@user)
  end

  def followlist
    @user = User.find(params[:id])
  end

  def followerlist
    @user = User.find(params[:id])
  end


end
