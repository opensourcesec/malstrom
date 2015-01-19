# VirusTotal module

require 'json'
require 'rest-client'

class VirusTotal
  def vtquery(hash)
    apikey = File.open('app/assets/api.key')

    begin
      vtrequest = RestClient.post "https://www.virustotal.com/vtapi/v2/file/report", :resource => "#{hash}", :apikey => "#{apikey}"
    end

    results = JSON.parse(vtrequest.body)
    vt_link = results["permalink"]

    if vt_link.nil?
      vt_status = "N/A"
    else
      total = results["total"]
      detected = results["positives"]
      detect_ratio = "#{detected}/#{total}"
      vt_status = detect_ratio
    end

    return vt_status
  end
end