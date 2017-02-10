class StaticPagesController < ApplicationController
  def home
    @name = "Home"
  end

  def help
    @name = "Help"
  end

  def about
    @name = "About"
  end

  def contact
    @name = "Contact"
  end
end
