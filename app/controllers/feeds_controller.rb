require 'retrieve'

class FeedsController < ApplicationController
  before_filter :authenticate_user!

  def list
    @feeds = Feeds.all
  end

  def new_feed
    @add_feed = Feeds.new
  end

  def update_feed(url)
    @update = Updater.new
    @update.retrieval(url)
  end
  helper_method :update_feed

  def run_all_feeds
    # function to run every feed in feed_listing
  end

  def scheduler
    # function to keep track of feed scheduling
  end
end
