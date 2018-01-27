class PagesController < ApplicationController
  layout "outside"
  skip_before_action :authenticate_user!

  def home
  end

  def about
  end

  def contact
  end

  def signup
  end
end
