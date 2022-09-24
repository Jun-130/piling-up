class PostsController < ApplicationController
  before_action :move_to_profile_new
  before_action :set_post, only: [:show, :edit, :update, :destroy]

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
    # 投稿した収支の年月までの、@post.userの損益の合計
    balance_total = Post.joins(:balance).select('posts.*, balance.amount').where(user_id: @post.user_id).where("month <= ?", @post.month.to_date)&.sum(:amount)
    @current_savings = @post.user.initial_savings + balance_total
  end

  def edit
  end
  
  def update
    if @post.update(post_params)
      update_balance
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
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

  def create_balance_and_fixed_profile
    Balance.create(amount: @post.calculate_balance, post_id: @post.id)
    profile = current_user.profile
    target = current_user.targets.find_by(status: 0)
    FixedProfile.create(
      age: profile.age.name, gender: profile.gender.name, household: profile.household.name, annual_income: profile.annual_income.name, prefecture: profile.prefecture.name,
      monthly_target: profile.monthly_target, target_deadline: target&.deadline, target_amount: target&.amount, post_id: @post.id
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
