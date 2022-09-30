class PostsController < ApplicationController
  before_action :move_to_profile_new
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    @posts = Post.order(created_at: :desc).includes(:user, :balance, :fixed_profile, :explanation)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      create_balance_and_fixed_profile
      @post.check_target_achievement_when_create
      redirect_to new_post_explanation_path(@post)
    else
      render :new
    end
  end

  def show
    @current_savings = @post.current_savings
    @fixed_profile = @post.fixed_profile
    @explanation = @post.explanation
    @comments = @post.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
  end
  
  def update
    if @post.update(post_params)
      update_balance
      @post.check_target_achievement_when_update
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    @post.user.check_target_achievement
    redirect_to root_path
  end

  private

  def move_to_profile_new
    if user_signed_in? && current_user.profile.nil?
      redirect_to new_profile_path
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if current_user.id != @post.user_id
  end

  def create_balance_and_fixed_profile
    Balance.create(amount: @post.calculate_balance, post_id: @post.id)
    profile = current_user.profile
    target = current_user.targets.find_by(completed: false)
    FixedProfile.create(
      age: profile.age.name, gender: profile.gender.name, household: profile.household.name, annual_income: profile.annual_income.name, prefecture: profile.prefecture.name,
      monthly_target: profile.monthly_target, target: target&.amount, post_id: @post.id
    )
  end

  def update_balance
    balance = Balance.find(@post.id)
    balance.update(amount: @post.calculate_balance)
  end

  def post_params
    params.require(:post).permit(
      :month, :net_income, :housing, :utilities, :internet,
      :groceries, :daily_necessities, :entertainment, :others
    ).merge(user_id: current_user.id)
  end
end
