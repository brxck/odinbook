module PostsHelper
  def reaction_button_class(post, name)
    button_class = "button is-rounded is-small is-outlined is-info"

    if post.reaction(name).count.zero?
      button_class
    else
      button_class + " badge is-badge-info"
    end
  end

  def post_reaction_button(post, name, style)
    link_to name.capitalize,
            reactions_path(reaction: { reactable_id: post.id,
                                      reactable_type: "Post",
                                      name: name }),
            method: :post,
            class: "#{reaction_button_class(post, name)} #{style}",
            "data-badge" => post.reaction(name).count
  end
end
