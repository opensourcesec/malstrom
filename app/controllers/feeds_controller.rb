class FeedsController < ApplicationController
  before_filter :authenticate_user!
  def feeds
    @feeds = Feeds.all
  end
end
