class TargetsController < ApplicationController
  before_action :move_to_profile_new

  def index
    @targets = Target.order(created_at: :desc)
    @target = Target.new
  end

  def create
    @target = Target.new(target_params)
    if @target.save
      redirect_to user_path(current_user)
    else
      render :index
    end
  end

  private

  def move_to_profile_new
    if user_signed_in? && current_user.profile.nil?
      redirect_to new_profile_path
    end
  end

  def target_params
    params.require(:target).permit(:deadline, :amount, :status).merge(user_id: current_user.id)
  end
end
