class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @entries  = current_user.entries.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def about
  end
end
