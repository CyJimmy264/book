class HomeController < ApplicationController
  before_action :require_login

  def index
    @records = Record.order(created_at: :desc)
  end
end
