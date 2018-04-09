class CommentsController < ApplicationController
  def create
    comment = current_user.comments.new(comment_params)

    flash.now[:danger] = "Your comment could not be saved." unless comment.save

    redirect_to comment.commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end
end
