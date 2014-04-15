require 'open-uri'
load 'find_artifacts.rb'

puts '[?] Please provide URL to retrieve:'
puts '>'
url = gets
ipaddr = FindArtifacts.new

open(url) {|f|
  f.each_line {|line|
    str = line.to_str
    ipaddr.ipv4(str)}
}
