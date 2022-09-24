class UsersController < ApplicationController
  before_action :move_to_profile_new
  # before_action :move_to_root

  def show
    @user = User.find(params[:id])
    @profile = Profile.find_by(user_id: @user.id)
    @target = @current_user.targets.find_by(status: 0)
    # @userのこれまでの損益の合計
    balance_total = Post.joins(:balance).select('posts.*, balance.amount').where(user_id: @user.id)&.sum(:amount)
    @current_savings = @user.initial_savings + balance_total
  end

  private

  def move_to_profile_new
    if user_signed_in? && current_user.profile.nil?
      redirect_to new_profile_path
    end
  end

  def move_to_root
    redirect_to root_path unless current_user&.id = params[:id]
  end
end
