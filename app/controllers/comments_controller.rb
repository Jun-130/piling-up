class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.includes(:user)
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to request.referer
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
