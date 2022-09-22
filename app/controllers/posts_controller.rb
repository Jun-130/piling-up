class PostsController < ApplicationController
  before_action :move_to_profile_setting, except: :index

  def index
  end

  def move_to_profile_setting
    unless !user_signed_in? || (user_signed_in? && current_user.profile.present?)
      redirect_to new_profile_path
    end
  end
end
