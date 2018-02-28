class CommentsController < ApplicationController
  def show
    redirect_to url_for controller: commentable_type,
                        action: show,
                        id: commentable_id
  end
end
