class SearchController < ApplicationController
  before_filter :authenticate_user!

  def indicators
  end

  def index
    # IOC search page handler
    if params[:search][0].to_s.length < 1
      redirect_to search_indicators_path
    else
      query = params[:search][0]
      @result = search(query)
    end
  end

  def search(search)
    # search function
    @results = Element.where("value like ?", "%#{search}%").page params[:page]
    if @results.blank?
      redirect_to search_indicators_path, :alert => "No results"
    end
  end
end
