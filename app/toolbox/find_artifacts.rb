class FindArtifacts
  def ipv4(line, tags)
    patt = '((?:(?:[12]\d?\d?|[1-9]\d|[1-9])\.){3}(?:[12]\d?\d?|[\d+]{1,2}))'
    matches = line.scan(/#{patt}/)
    matches.each do |match|
      match = match[0]
      if match == nil
      elsif Element.exists?(:value => match)
      else
        @ip = Element.create do |i|
          i.value = match
          i.kind = 'IP'
          i.tag_list = tags
        end
      end
    end
  end

  def domain(line, tags)
    patt = '([a-z0-9]+(?:[\-|\.][a-z0-9]+)*(?:\[\.\]|\.)(?:com|net|ru|org|de|uk|jp|br|pl|info|fr|it|cn|in|su|pw|biz|co|eu|nl))'
    matches = line.scan(/#{patt}/)
    matches.each do |match|
      match = match[0]
      if match == nil
      elsif Element.exists?(:value => match)
      else
        @domain = Element.create do |i|
          i.value = match
          i.kind = 'Domain'
          i.tag_list = tags
        end
      end
    end
  end

  def md5(line, tags)
    patt = "([A-Fa-f0-9]{32})"
    matches = line.scan(/#{patt}/)
    matches.each do |match|
      match = match[0]
      if match == nil
      elsif Element.exists?(:value => match)
      else
        @domain = Element.create do |i|
          i.value = match
          i.kind = 'MD5'
          i.tag_list = tags
        end
      end
    end
  end
end