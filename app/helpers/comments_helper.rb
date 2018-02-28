module CommentsHelper
  # Adds reaction counter if comments are > 0.
  def comment_reaction_text(comment, name)
    if comment.reaction(name).count.zero?
       name.capitalize
    else 
      "#{name.capitalize} [#{comment.reaction(name).count}]"
    end
  end

  # Generates reaction link for comments.
  def comment_reaction_link(comment, name)
    link_to comment_reaction_text(comment, name),
    reactions_path(reaction: { reactable_id: comment.id,
                               reactable_type: "Comment",
                               name: name }),
    method: :post
  end
end
