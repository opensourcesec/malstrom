class FindArtifacts
  def ipv4(item)
    patt = '[\b\w](?:[0-9]{1,3}\.){3}[0-9]{1,3}[\b\w]'
    matches = item.scan(/#{patt}/)
    if matches == nil
    else
      ip = Element.new do |i|
        i.value = matches
        i.type = "IP"
      end
    end
  end

  def domain(item)
    patt = ''
  end
end