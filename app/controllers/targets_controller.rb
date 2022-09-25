class TargetsController < ApplicationController
  before_action :move_to_profile_new
  before_action :authenticate_user!, only: :index

  def index
    @targets = Target.where(user_id: current_user.id).order(created_at: :desc)
    @target = Target.new
  end

  def create
    @target = Target.new(target_params)
    if @target.save
      redirect_to user_path(current_user)
    else
      @targets = Target.where(user_id: current_user.id).order(created_at: :desc)
      render :index
    end
  end

  private

  def move_to_profile_new
    if user_signed_in? && current_user.profile.nil?
      redirect_to new_profile_path
    end
  end

  def move_to_index
    redirect_to root_path if current_user.id != @post.user_id
  end

  def target_params
    params.require(:target).permit(:deadline, :amount, :status).merge(user_id: current_user.id)
  end
end
