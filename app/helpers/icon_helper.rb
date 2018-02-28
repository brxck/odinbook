module IconHelper
  # Returns the material icon for the given reaction.
  def reaction_icon(name, size = 18)
    icons = { bless: "spa", smite: "flash_on" }
    mi.send(icons[name.to_sym]).send("md_#{size.to_s}".to_sym)
  end

    # Selects appropriate icon for notification type.
  def notification_icon(n)
    case n.notifiable_type
    when "FriendRequest"
      mi.person_add.md_18
    when "Reaction"
      reaction_icon(n.notifiable.name)
    end
  end
end