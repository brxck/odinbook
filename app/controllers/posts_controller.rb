class PostsController < ApplicationController
  before_action :set_post, only: %i[show]

  def new
  end

  def create
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
  end

  def destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
