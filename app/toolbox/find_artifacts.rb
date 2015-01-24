class FindArtifacts
  def ipv4(line, feed, feed_name, tags)
    patt = '((?:(?:[12]\d?\d?|[1-9]\d|[1-9])\.){3}(?:[12]\d?\d?|[\d+]{1,2}))'
    matches = line.scan(/#{patt}/)
    matches = matches.join
    if matches == nil
    elsif Element.exists?(:value => matches)
      feed = Feeds.find_by_url(feed)
      @ip = Element.find_by_value(matches)
    else
      @ip = Element.create do |i|
        i.value = matches
        i.kind = 'IP'
        i.source = feed_name
        i.tag_list = tags
      end
    end
  end

  def domain(line, feed, feed_name, tags)
    patt = '([a-z0-9]+(?:[\-|\.][a-z0-9]+)*\.(?:com|net|ru|org|de|uk|jp|br|pl|info|fr|it|cn|in|su|pw|biz|co))'
    matches = line.scan(/#{patt}/)
    matches = matches.join
    if matches == nil
    elsif Element.exists?(:value => matches)
      feed = Feeds.find_by_url(feed)
      @domain = Element.find_by_value(matches)
    else
      puts matches
      @domain = Element.create do |i|
        i.value = matches
        i.kind = 'Domain'
        i.source = feed_name
        i.tag_list = tags
      end
    end
  end
end