class UsersController < ApplicationController
  before_action :move_to_profile_new
  # before_action :move_to_root

  def show
    @user = User.find(params[:id])
    @profile = Profile.find_by(user_id: @user.id)
    @target = @user.targets.find_by(completed: false)
    @current_savings = @user.current_savings
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
