class Settings::BaseController < ApplicationController
  before_action :require_login

  def active?(name)
    name == controller_name ? :active : nil
  end
  helper_method :active?
end
