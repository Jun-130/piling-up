class UsersController < ApplicationController
  before_action :move_to_profile_new

  def show
    @user = User.find(params[:id])
    @profile = Profile.find_by(user_id: @user.id)
    @introduction = Introduction.find_by(user_id: @user.id)
    @target = @user.targets.find_by(completed: false)
    @current_savings = @user.current_savings
  end

  private

  def move_to_profile_new
    redirect_to new_profile_path if user_signed_in? && current_user.profile.nil?
  end
end
