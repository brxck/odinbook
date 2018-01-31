module UsersHelper
  # Generate contextual button to add/remove friend or friend request.
  def friend_button(friend)
    button_class = "button"

    if current_user.friends.find_by(id: friend.id)
      button_to "Unfriend", friend_path(friend.id), method: :delete,
              class: button_class + " is-outlined is-danger"
    elsif (friend_request = current_user.friend_requests.find_by(friend_id: friend.id))
      button_to "Cancel Request", friend_request, method: :delete,
              class: button_class + " is-outlined is-info"
    else
      button_to "Add Friend",
              friend_requests_path(friend_id: friend.id),
              class: button_class + " is-info"
    end
  end
end
