class ThreatsController < ApplicationController
  def tags
  end

  def profile
    @tag_matches = []
    @tag_name = params[:tag]
    set = Element.all
    set.each do |item|
      item.tag_list.each do |tag|
        if tag == @tag_name
          @tag_matches.push(item.value)
        end
      end
    end
    @tagged = @tag_matches.length
  end
end