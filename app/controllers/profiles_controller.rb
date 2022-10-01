class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_profile, only: [:edit, :update]
  before_action :move_to_index, only: :edit
  before_action :move_to_user_page, only: :new

  def new
    @profile = Profile.new
  end

  def create
    profile = Profile.new(profile_params)
    if profile.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if current_user.id != @profile.user_id
  end

  def move_to_user_page
    redirect_to user_path(current_user) if current_user.profile.present?
  end

  def profile_params
    params.require(:profile).permit(
      :age_id, :gender_id, :household_id, :annual_income_id, :prefecture_id, :monthly_target
    ).merge(user_id: current_user.id)
  end
end
