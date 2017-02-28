class StaticPagesController < ApplicationController
  def home
    @name = "Home"
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed
    end
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
