module CommentsHelper
  def comment_reaction_text(comment, name)
    if comment.reaction(name).count.zero?
       name.capitalize
    else 
      "[#{comment.reaction(name).count}] #{name.capitalize}"
    end
  end

  def comment_reaction_link(comment, name)
    link_to comment_reaction_text(comment, name),
    reactions_path(reaction: { reactable_id: comment.id,
                               reactable_type: "Comment",
                               name: name }),
    method: :post
  end
end
