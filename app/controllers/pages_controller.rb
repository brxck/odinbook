class PagesController < ApplicationController
  def home
    render 'home', layout: 'containerless'
  end

  def about
  end

  def contact
  end
end
