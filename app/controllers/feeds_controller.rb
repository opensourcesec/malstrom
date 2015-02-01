require 'retrieve'

class FeedsController < ApplicationController
  before_filter :authenticate_user!

  def list
    # Local var for Feed listing
    @feeds = Feeds.all
  end

  def feed_params
    params.require(:feeds).permit(:name, :url, :tag_list)
  end

  def new_feed
    @add_feed = Feeds.new
  end

  def create
    @add_feed = Feeds.new(feed_params)
    if @add_feed.save
      redirect_to :feeds_list, :notice => "Feed has been saved successfully!"
    else
      flash.now[:alert] = "Error: Feed can not be saved"
      render :feeds_new_feed_path
    end
  end

  def run_feed
    @update = Updater.new
    # New job for feed update
    Thread.new { (@update.retrieval(params[:url], params[:name], params[:tags])) }
    # Redirect upon job initiation
    if @update
      redirect_to :feeds_list, :notice => "Feed update initiated!"
    else
      flash.now[:alert] = "Error: Cannot run feed at this time"
      render :feeds_list_path
    end
  end
  helper_method :update_feed

  def delete_feed
    @feedname = Feeds.find_by_name(params[:name]).delete
    if @feedname
      redirect_to :feeds_list, :notice => "Feed deleted successfully!"
    else
      flash.now[:alert] = "Error: Cannot delete feed at this time"
      render :feeds_list_path
    end
  end
  helper_method :delete_feed

  def scheduler
    # function to keep track of feed scheduling
  end
end
