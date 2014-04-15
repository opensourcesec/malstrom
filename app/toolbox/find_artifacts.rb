class FindArtifacts
  def ipv4(item)
    patt = '[\b\w](?:[0-9]{1,3}\.){3}[0-9]{1,3}[\b\w]'
    matches = item.scan(/#{patt}/)
    if matches == nil
    else
      ip = Element.new do |i|
        i.value = matches
        i.type = "IP"
      ip.save
      end
    end
  end

  def domain(item)
    patt = '([a-z0-9]+(?:[\-|\.][a-z0-9]+)*\.[a-z]{2,5}(?:[0-9]{1,5})?)'
    matches = item.scan(/#{patt}/)
    if matches == nil
    else
      puts matches
      domain = Element.new do |i|
        i.value = matches
        i.type = "Domain"
      domain.save
      end
    end
  end
end