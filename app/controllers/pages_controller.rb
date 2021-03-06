class PagesController < ApplicationController
  layout "outside", except: %i[home search]
  skip_before_action :authenticate_user!, except: :home
  before_action :redirect_signed_in, only: %i[login signup]

  def home
    @posts = Post.where(user: current_user)
                 .or(Post.where(user: current_user.friends))
                 .page(params[:page])
                 .includes(:user, comments: :user)
  end

  def search
    if params[:search]
      @results = User.where("name LIKE ?", params[:search])
                     .page(params[:page])
    else
      @users = User.all.page(params[:page])
    end
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
