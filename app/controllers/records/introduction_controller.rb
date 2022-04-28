class Records::IntroductionController < ApplicationController
  def new
    @introduction = Record.new
  end

  def create
    raise params.to_s
  end
end
