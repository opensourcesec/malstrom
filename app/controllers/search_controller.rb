class SearchController < ApplicationController
  before_filter :authenticate_user!

  def indicators
    @result = Element.all.each { |i| print i }
  end

  def index
    if params[:search]
      @elements = Element.search(params[:search])
    else
      flash.now[:alert] = "Error: Incorrect search options or no input received"
      render search_indicators_path
      #@elements = Element.all.order('created_at DESC')
    end
  end
end
