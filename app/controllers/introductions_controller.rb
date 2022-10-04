class IntroductionsController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_profile_new
  before_action :set_introduction, only: [:edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]
  before_action :move_to_user_page, only: :new

  def new
    @introduction = Introduction.new
  end

  def create
    @introduction = Introduction.new(introduction_params)
    if @introduction.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @introduction.update(introduction_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @introduction.destroy
    redirect_to user_path(current_user)
  end

  private

  def move_to_profile_new
    redirect_to new_profile_path if user_signed_in? && current_user.profile.nil?
  end

  def set_introduction
    @introduction = Introduction.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if current_user.id != @introduction.user_id
  end

  def move_to_user_page
    redirect_to user_path(current_user) if current_user.introduction.present?
  end

  def introduction_params
    params.require(:introduction).permit(:title1, :text1, :title2, :text2).merge(user_id: current_user.id)
  end
end
