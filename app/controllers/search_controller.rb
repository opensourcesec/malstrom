class SearchController < ApplicationController
  before_filter :authenticate_user!

  def indicators
  end

  def index
    if params[:search][0].to_s.length < 1
      flash.now[:alert] = "Error: Incorrect search options or no input received"
      redirect_to search_indicators_path
    else
      query = params[:search][0]
      @result = search(query)
    end
  end

  def search(search)
    @results = Element.where("value like ?", "%#{search}%")
    if @results.blank?
      flash.now[:alert] = "Error: 0 results found"
      render search_indicators_path
    end
  end
end
