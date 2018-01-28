class PostsController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def index
    @posts = Post.where(user: current_user).or(Post.where(user: current_user.friends))
  end

  def show
  end

  def destroy
  end
end
