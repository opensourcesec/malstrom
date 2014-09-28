class SearchController < ApplicationController
  before_filter :authenticate_user!

  def indicators
  end

  def index
    if params[:search]
      @results = search(params[:search][0])
    else
      flash.now[:alert] = "Error: Incorrect search options or no input received"
      render search_indicators_path
      #@elements = Element.all.order('created_at DESC')
    end
  end

  def search(search)
    @results = Element.where("value like ?", "%#{search}%")
    if @results.nil?
      flash.now[:alert] = "Error: 0 results found"
      render search_indicators_path
    else
      render
    end
  end
end
