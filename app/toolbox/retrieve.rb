require 'open-uri'
load 'find_artifacts.rb'

puts '[?] Please provide URL to retrieve:'
print '> '
url = gets
ipaddr = FindArtifacts.new

open(url) {|f|
  f.each_line {|line|
    str = line.to_str
    if str.start_with?("#")
    else
      ipaddr.domain(str)
      ipaddr.ipv4(str)
    end}
}
