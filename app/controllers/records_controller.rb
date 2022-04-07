class RecordsController < ApplicationController
  before_action :require_login

  def create
    @record = Record.create! params
                               .permit(:content).to_h
                               .merge(author_id: current_user.id)

    redirect_to root_path
  end
end
