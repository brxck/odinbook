class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_notifications, unless: -> { current_user.nil? }

  def set_notifications
    @notifications = current_user.notifications
  end
end
