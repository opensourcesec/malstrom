class SearchController < ApplicationController
  before_filter :authenticate_user!

  def indicators
    @result = Element.all.each { |i| print i } # params[:indicators]
  end
end
