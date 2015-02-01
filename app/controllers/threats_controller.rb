class ThreatsController < ApplicationController
  def tags
  end

  def profile
    @ioc_matches = []
    @mal_matches = []
    @tag_name = params[:tag]

    ioc_set = Element.all
    mal_set = Sample.all

    # Iterate over all IOCs
    ioc_set.each do |item|
      item.tag_list.each do |tag|
        if tag == @tag_name
          @ioc_matches.push(item.value)
        end
      end
    end

    # Iterate over all Samples
    mal_set.each do |item|
      item.tag_list.each do |tag|
        if tag == @tag_name
          @mal_matches.push(item.md5sum)
        end
      end
    end

    @tagged = @ioc_matches.length + @mal_matches.length
  end
end