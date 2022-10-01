class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(@user)
    redirect_to request.referer
  end

  def followees
    @followees = @user.followees
    redirect_to request.referer unless @followees.present?
  end

  def followers
    @followers = @user.followers
    redirect_to request.referer unless @followers.present?
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
