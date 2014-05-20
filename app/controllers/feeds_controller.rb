class FeedsController < ApplicationController
  before_filter :authenticate_user!
  def list
    @feeds = Feeds.all
  end

  def new_feed

  end
end
