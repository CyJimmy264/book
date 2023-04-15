class UsersController < ApplicationController
  before_action :require_login

  def update
    current_user.update profile_params

    if current_user.save
      redirect_back fallback_location: user_path(current_user)
    else
      render :show, alert: 'Can not update user profile.'
    end
  end

  private

  def profile_params
    params.require(:user).permit(:public_key, :fingerprint)
  end
end
