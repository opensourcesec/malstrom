class SearchController < ApplicationController
  before_filter :authenticate_user!
  def search
    @all_elements = Element.all
  end
end
