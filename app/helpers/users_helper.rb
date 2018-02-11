module UsersHelper
  # Generate contextual button to add/remove friend or friend request.
  def friend_button(friend)
    if current_user.friends.find_by(id: friend.id)
      link_to "Unfriend", friend_path(friend.id), method: :delete,
                class: "button is-outlined is-info", id: "unfriend"
                
    elsif (friend_request = current_user.friend_requests.find_by(friend_id: friend.id))
      link_to "Cancel Request", friend_request, method: :delete,
                class: "button is-outlined is-info", id: "cancel-request"

    elsif (friend_request = current_user.pending_requests.find_by(user_id: friend.id))
        link_to("Accept Request", friend_request, method: :patch,
                  class: "button is-success") +
        link_to("Reject", friend_request, method: :delete,
                    class: "button is-outlined is-success")

    else
      link_to "Add Friend",
                friend_requests_path(friend_id: friend.id),
                class: "button is-info level-item", id: "add-friend"
    end
  end
end
