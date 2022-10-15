class UsersController < ApplicationController
  before_action :require_login

  def show; end

  def update
    @user = current_user
    @user.public_key = params.require(:user).require(:public_key)
    @user.fingerprint = params.require(:user).require(:fingerprint)
    @user.save
    redirect_to root_path
  end
end
