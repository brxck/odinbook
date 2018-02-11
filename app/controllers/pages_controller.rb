class PagesController < ApplicationController
  layout "outside", except: %i[home]
  skip_before_action :authenticate_user!
  before_action :redirect_signed_in, only: %i[login signup]

  def home
    @posts = Post.where(user: current_user)
                 .or(Post.where(user: current_user.friends))
    
    @notifications = current_user.notifications
  end

  def login
  end

  def about
  end

  def contact
  end

  def signup
  end

  private

  def redirect_signed_in
    redirect_to home_path if user_signed_in?
  end
end
