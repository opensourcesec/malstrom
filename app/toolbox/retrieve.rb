require 'open-uri'
load 'find_artifacts.rb'

ipaddr = FindArtifacts.new

class Updater
  def retrieval(url)
    open(url) {|f|
      f.each_line {|line|
        str = line.to_str
        if str.start_with?("#")
        else
          ipaddr.domain(str)
          ipaddr.ipv4(str)
        end}
      }
  end

  def dedupe(artifact)
    # Checks database to see if value already exists

  end
end
