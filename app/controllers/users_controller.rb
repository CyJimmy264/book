class UsersController < ApplicationController
  before_action :require_login

  def index
    @users = User.where.not(public_key: nil).where.not(id: current_user.id).order(email: :asc)
  end

  def update
    @user = current_user
    @user.public_key = params.require(:user).require(:public_key)
    @user.save
    redirect_to root_path
  end
end
