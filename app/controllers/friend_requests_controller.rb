class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: %i[update destroy]
  after_action :notify, only: %i[create update]

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      # flash[:success] = "Friend request sent."
    else
      flash[:danger] = "Friend request could not be sent."
    end
    redirect_back fallback_location: root_path
  end

  def update
    @friend_request.accept
    redirect_back fallback_location: root_path
  end

  def destroy
    @friend_request.destroy
    redirect_back fallback_location: root_path
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end 

  def notify
    if action_name == "create"
      message = "#{current_user.name} sent you a friend request!"
    else
      message = "#{current_user.name} accepted your friend request!"
    end

    @friend_request.notifications.create(user_id: @friend_request.friend_id,
                                         body: message)
  end
end
