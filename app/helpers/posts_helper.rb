module PostsHelper
  # Adds badge to reaction button if reactions are > 0.
  def reaction_button_count(post, name)
    return if (count = post.reaction(name).count).zero?
    " · #{count}"
  end

  # Generates reaction buttons for post.
  def post_reaction_button(post, name, style)
    link_to reaction_icon(name).to_s + name.capitalize + reaction_button_count(post, name),
            reactions_path(reaction: { reactable_id: post.id,
                                       reactable_type: "Post",
                                       name: name }),
            method: :post,
            class: "button is-rounded is-small is-outlined is-info " + style
  end
end
