class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    profile = Profile.new(profile_params)
    if profile.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(
      :age_id, :gender_id, :household_id, :annual_income_id, :prefecture_id, :monthly_target
    ).merge(user_id: current_user.id)
  end
end
