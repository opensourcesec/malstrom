class FindArtifacts
  def ipv4(line, feed, feed_name)
    patt = '((?:(?:[12]\d?\d?|[1-9]\d|[1-9])\.){3}(?:[12]\d?\d?|[\d+]{1,2}))'
    matches = line.scan(/#{patt}/)
    matches = matches.join
    if matches == nil
    elsif Element.exists?(:value => matches)
      feed = Feeds.find_by_url(feed)
      @ip = Element.find_by_value(matches)
      #@ip.tags = feed.tags
    else
      @ip = Element.create do |i|
        i.value = matches
        i.kind = 'IP'
        i.source = feed_name

      end
    end
  end

  def domain(line, feed, feed_name)
    patt = '([a-z0-9]+(?:[\-|\.][a-z0-9]+)*\.[a-z]{2,5}(?:[0-9]{1,5})?)'
    matches = line.scan(/#{patt}/)
    matches = matches.join
    if matches == nil
    elsif Element.exists?(:value => matches)
      feed = Feeds.find_by_url(feed)
      @domain = Element.find_by_value(matches)
      #@domain.tags = feed.tags
    else
      puts matches
      @domain = Element.create do |i|
        i.value = matches
        i.kind = 'Domain'
        i.source = feed_name
      end
    end
  end
end