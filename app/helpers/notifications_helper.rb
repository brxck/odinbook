module NotificationsHelper
  # Generates deletion link for a friend request (and its dependent notification)
  # or just the notification.
  def notification_delete(n)
    if n.notifiable_type == "FriendRequest"
      link_to nil, FriendRequest.find(n.notifiable_id), method: :delete,
                                                        class: "delete is-small"
    else
      link_to nil, n, method: :delete, class: "delete is-small"
    end
  end

  def get_root(node)
    return node unless node.respond_to?(:parent)
    get_root(node.parent)
  end

  # Constructs link to notification's content.
  def notification_link(n)
    url_for get_root(n.notifiable)
  end

  # Chooses alert icon depending on whether notifications are present or not.
  def notification_badge
    if current_user.notifications.any?
      mi.notifications
    else
      mi.notifications_none
    end
  end
end
