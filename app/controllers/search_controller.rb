class SearchController < ApplicationController
  before_filter :authenticate_user!

  def search
    @result = Element.all.each { |i| print i } # params[:search]
  end
end
