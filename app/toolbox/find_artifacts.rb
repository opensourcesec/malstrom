class FindArtifacts
  def ipv4(line, feed)
    patt = '[\b\w](?:[0-9]{1,3}\.){3}[0-9]{1,3}[\b\w]'
    matches = line.scan(/#{patt}/)
    if matches == nil
    elsif Element.exists?(:value => matches)
      feed = Feeds.find_by_url(feed)
      ip = Element.find_by_value(matches)
      ip.tags = feed.tags
    else
      ip = Element.new do |i|
        i.value = matches
        i.type = 'IP'
      ip.save
      end
    end
  end

  def domain(line, feed)
    patt = '([a-z0-9]+(?:[\-|\.][a-z0-9]+)*\.[a-z]{2,5}(?:[0-9]{1,5})?)'
    matches = line.scan(/#{patt}/)
    if matches == nil
    elsif Element.exists?(:value => matches)
      feed = Feeds.find_by_url(feed)
      domain = Element.find_by_value(matches)
      domain.tags = feed.tags
    else
      puts matches
      domain = Element.new do |i|
        i.value = matches
        i.type = 'Domain'
      domain.save
      end
    end
  end
end