class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_profile_new
  before_action :set_user

  def show
    @profile = Profile.find_by(user_id: @user.id)
    @introduction = Introduction.find_by(user_id: @user.id)
    @target = @user.targets.find_by(completed: false)
    @current_savings = @user.current_savings
  end

  def posts
    @user_posts = @user.posts.order(created_at: :desc).includes(:explanation)
  end

  def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.order(created_at: :desc).includes(:user, :explanation).find(likes)
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

  def move_to_profile_new
    redirect_to new_profile_path if user_signed_in? && current_user.profile.nil?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
