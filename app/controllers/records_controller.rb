class RecordsController < ApplicationController
  before_action :require_login

  def sign
    redirect_to root_path, notice: 'Signed successfully'
  end
end
