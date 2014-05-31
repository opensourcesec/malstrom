require 'retrieve'

class FeedsController < ApplicationController
  before_filter :authenticate_user!

  def list
    @feeds = Feeds.all
  end

  def new_feed
    @add_feed = Feeds.new
  end

  def create
    @add_feed = Feeds.new
    if @add_feed.save
      redirect_to :feeds_list, :notice => "Feed has been saved successfully."
    else
      flash.now[:notice] = "Feed can not be saved, an error occurred"
      render :feeds_new_feed_path
    end
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
