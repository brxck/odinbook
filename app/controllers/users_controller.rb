class UsersController < ApplicationController
  before_action :set_user, except: :edit

  def edit
    @user = current_user
  end

  def update
  end

  def show
    @posts = @user.posts
    @profile = @user.profile
    @friends = @user.friends
  end

  def index
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
