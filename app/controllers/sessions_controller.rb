class SessionsController < Devise::SessionsController
  def new
    respond_to do |format|
      format.html { super }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('notifications', partial: 'notifications')
      end
    end
  end
end
