class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:signup_menu]

  def signup_menu
    if user_signed_in?
      redirect_to root_path
    end
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
