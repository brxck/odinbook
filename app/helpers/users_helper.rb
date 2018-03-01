module UsersHelper
  # Generate contextual button to add/remove friend or friend request.
  def friend_button(friend)
    # Unfriend
    if current_user.friends.find_by(id: friend.id)
      link_to mi.person_outline.to_s + "Unfriend", friend_path(friend.id), method: :delete,
                                                                           class: "button is-outlined is-info", id: "unfriend"

    # Cancel Request
    elsif (friend_request = current_user.friend_requests.find_by(friend_id: friend.id))
      link_to mi.remove.to_s + "Cancel Request", friend_request, method: :delete,
                                                                 class: "button is-outlined is-info", id: "cancel-request"

    # Accept/Reject Request
    elsif (friend_request = current_user.pending_requests.find_by(user_id: friend.id))
      link_to(mi.person.to_s + "Accept Request", friend_request, method: :patch,
                                                                 class: "button is-success") +
        link_to("Reject", friend_request, method: :delete,
                                          class: "button is-outlined is-success")

    # Add Friend
    else
      link_to (mi.person_add.to_s + "Add Friend"),
              friend_requests_path(friend_id: friend.id), method: :post,
                                                          class: "button is-info level-item", id: "add-friend"
    end
  end
end
