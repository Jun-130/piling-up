class ExplanationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_post
  before_action :set_explanation, only: [:edit, :update, :destroy]
  before_action :move_to_index, only: [:new, :edit, :destroy]

  def new
    @explanation = Explanation.new
  end

  def create
    @explanation = Explanation.new(explanation_params)
    if @explanation.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @explanation.update(explanation_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @explanation.destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_explanation
    @explanation = Explanation.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if current_user.id != @post.user_id
  end

  def explanation_params
    params.require(:explanation).permit(:text).merge(post_id: params[:post_id])
  end
end
