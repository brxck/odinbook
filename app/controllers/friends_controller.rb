class FriendsController < ApplicationController
  before_action :set_friend, only: :destroy
  def index
    @friends = current_user.friends.page(params[:page])
  end

  def destroy
    current_user.remove_friend(@friend)
    redirect_back(fallback_location: root_path)
  end

  private

  def set_friend
    @friend = current_user.friends.find(params[:id])
  end
end
