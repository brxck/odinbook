class PagesController < ApplicationController
  layout "outside"
  skip_before_action :authenticate_user!
  before_action :redirect_signed_in, only: %i[login signup]

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
    redirect_to about_path if user_signed_in?
  end
end
