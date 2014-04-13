
class FindArtifacts
  def ipv4(item)
    patt = '[\b\w](?:[0-9]{1,3}\.){3}[0-9]{1,3}[\b\w]'
    matches = item.scan(/#{patt}/)
    if matches == nil
    else
      puts matches
    end
  end
end