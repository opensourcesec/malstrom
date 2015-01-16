# VirusTotal module

require 'json'
require 'rest-client'

class VirusTotal
  def vtquery(file, hash)
    @sample_name = Sample.find_by_malz_file_name(file)

    begin
      vtrequest = RestClient.post "https://www.virustotal.com/vtapi/v2/file/report", :resource => "#{hash}", :apikey => "#{apikey}"
    rescue
      puts "[-] Could not connect to VirusTotal's database.. Check network connection.".red
      exit(0)
    end

    results = JSON.parse(vtrequest.body)
    vt_link = results["permalink"]

    if vt_link.nil?
      vt_status = "N/A"
    else
      total = results["total"]
      detected = results["positives"]
      detect_ratio = "#{detected}/#{total}"
      puts detect_ratio
    end
  end
end