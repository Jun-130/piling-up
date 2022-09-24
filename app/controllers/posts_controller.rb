class PostsController < ApplicationController
  before_action :move_to_profile_new, except: :index

  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      create_balance_and_fixed_profile
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def move_to_profile_new
    unless !user_signed_in? || (user_signed_in? && current_user.profile.present?)
      redirect_to new_profile_path
    end
  end

  def create_balance_and_fixed_profile
    Balance.create(amount: @post.calculate_balance, post_id: @post.id)
    profile = current_user.profile
    target = current_user.targets.find_by(status: 0)
    FixedProfile.create(
      age: profile.age.name, gender: profile.gender.name, household: profile.household.name, annual_income: profile.annual_income.name, prefecture: profile.prefecture.name,
      monthly_target: profile.monthly_target, target: target&.amount, post_id: @post.id
    )
  end

  def post_params
    params.require(:post).permit(
      :month, :net_income, :housing, :utilities, :internet,
      :groceries, :daily_necessities, :entertainment, :others
    ).merge(user_id: current_user.id)
  end
end
