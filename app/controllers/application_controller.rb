class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :move_to_profile_setting

  private

  def move_to_profile_setting
    unless !user_signed_in? || (user_signed_in? && current_user.profile.present?)
      redirect_to new_profile_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :initial_savings])
  end
end
