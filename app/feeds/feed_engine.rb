class FeedEngine
  def feed_listing
    Feeds.all.each do |feed|
      # the code here is called once for each user
      # user is accessible by 'feed' variable
    end
  end

  def update_feed(url)
    update = Retrieve::Updater.new
    run = update.retrieval(url)
  end

  def run_all_feeds
    # function to run every feed in feed_listing
  end

  def scheduler
    # function to keep track of feed scheduling
  end
end