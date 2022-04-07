class ApplicationController < ActionController::Base
  protected

  def require_login
    authenticate_user!
  end
end
