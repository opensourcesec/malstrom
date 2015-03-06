class ThreatsController < ApplicationController

  def tags
  end

  def analysis
    @profile = params[:profile]
  end

  def ioc_list
    @ioc_matches = []
    @mal_matches = []
    @tag_name = params[:tag]

    # Query IOCs table
    Element.tagged_with(@tag_name).find_each do |item|
      @ioc_matches.push(item.value)
      end

    # Query Samples table
    Sample.tagged_with(@tag_name).find_each do |item|
      @mal_matches.push(item.md5sum)
    end

    @tagged = @ioc_matches.length + @mal_matches.length
  end
end