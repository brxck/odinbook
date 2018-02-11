module NotificationsHelper
  def notification_icon(n)
    case n.notifiable_type
    when "FriendRequest"
      mi.person_add.md_18
    end
  end

  def notification_delete(n)
    case n.notifiable_type
    when "FriendRequest"
      deletable = FriendRequest.find(n.notifiable_id)
    else
      deletable = n
    end

    link_to nil, deletable, method: :delete, class: "delete is-small"
  end

  def notification_link(n)
    url_for controller: n.notifiable_type.pluralize.underscore,
            action: :show,
            id: n.notifiable_id
  end

  def notification_badge
    if current_user.notifications.any?
      mi.notifications
    else
      mi.notifications_none
    end
  end
end
