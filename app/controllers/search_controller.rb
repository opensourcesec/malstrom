class SearchController < ApplicationController
  before_filter :authenticate_user!

  def indicators
    @result = Element.all.each { |i| print i }
'''
    if params[:search]
      @elements = Element.search(params[:search])
    else
      @elements = Element.all.each { |i| print i }
    end
'''
  end
end
