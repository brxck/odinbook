module NotificationsHelper
  def notification_icon(n)
    case n.notifiable_type
    when "FriendRequest"
      mi.person_add.md_18
    end
  end

  def notification_delete(n)
    if n.notifiable_type == "FriendRequest"
      deletable = FriendRequest.find(n.notifiable_id)
    else
      deletable = n
    end

    link_to nil, deletable, method: :delete, class: "delete is-small"
  end
end
