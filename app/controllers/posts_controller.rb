class PostsController < ApplicationController
  before_action :set_post, only: %i[show]

  def create
    @post = @current_user.posts.new(post_params)

    flash[:danger] = @post.errors.full_messages.to_sentence unless @post.save

    redirect_to :home
  end

  def edit
  end

  def update
  end

  def index
  end

  def show
    @user = @post.user
    @profile = @user.profile
    @comment = @post.comments.new
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:body, :link)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
