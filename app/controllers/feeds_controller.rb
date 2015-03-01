require 'find_artifacts'
require 'docsplit'

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
    update = Updater.new
    # New job for feed update
    Thread.new { update.retrieval(params[:url], params[:tags]) }
    # Redirect upon job initiation
    if update
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

  def extract
    # function to import indicators of compromise
    extractor = FindArtifacts.new
    file_name = params[:ioc_set].original_filename
    file_data = params[:ioc_set].tempfile.open.read
    tmp_path = "tmp/docsplit/#{file_name}"
    File.open(tmp_path, 'wb') { |file| file.write("#{file_data}") }
    data = Docsplit.extract_text(tmp_path, :ocr => false)

    # New jobs for IOC import
    Thread.new { extractor.ipv4(data, params[:tags][:upload_ioc]) }
    Thread.new { extractor.domain(data, params[:tags][:upload_ioc]) }
    Thread.new { extractor.md5(data, params[:tags][:upload_ioc]) }

    if extractor
      File.delete(tmp_path)
      File.delete(file_name)
      redirect_to :feeds_import, :notice => "IOC's are being processed!"
    else
      flash.now[:alert] = "Error: IOC file could not be processed"
      redirect_to :feeds_import
    end
  end
end
