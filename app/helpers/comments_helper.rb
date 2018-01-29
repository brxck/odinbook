module CommentsHelper
  def comment_reaction_text(comment, reaction)
    if comment.reaction(reaction).count.zero?
       reaction.capitalize
    else 
      "[#{comment.reaction(reaction).count}] #{reaction.capitalize}"
    end
  end

  def comment_reaction_link(comment, reaction)
    link_to comment_reaction_text(comment, reaction),
    reactions_path(reaction: { reactable_id: comment.id,
                               reactable_type: "Comment",
                               name: reaction }),
    method: :post
  end
end
