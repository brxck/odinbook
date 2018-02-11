class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[destroy]
  
  def destroy
    @notification.destroy
    redirect_back fallback_location: root_path
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
