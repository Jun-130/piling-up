class StatusesController < ApplicationController
  before_action :authenticate_user!

  def create
    Status.create(user_id: current_user.id)
    redirect_to request.referer
  end

  def destroy
    status = Status.find_by(user_id: current_user.id)
    status.destroy
    redirect_to request.referer
  end
end
