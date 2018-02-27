module NotificationsHelper
  # Selects appropriate icon for notification type.
  def notification_icon(n)
    case n.notifiable_type
    when "FriendRequest"
      mi.person_add.md_18
    when "Reaction"
      if n.notifiable.name == "bless"
        mi.wifi_tethering.md_18
      elsif n.notifiable.name == "smite"
        mi.flash_on.md_18
      end
    end
  end

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

  # Constructs link to notification's content.
  def notification_link(n)
    url_for controller: n.notifiable_type.pluralize.underscore,
            action: :show,
            id: n.notifiable_id
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
