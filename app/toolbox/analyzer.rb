require 'hex_string'
require 'digest'
require 'exifr'
require 'metasm'
require 'pe'
require_relative 'virustotal'

class Analysis

######################### Hashing Module ########################

  def hashes(sample, file)
    sha256hash = Digest::SHA256.file(sample).hexdigest
    sha1hash = Digest::SHA1.file(sample).hexdigest
    md5hash = Digest::MD5.file(sample).hexdigest
    samp = Sample.find_by_malz_file_name(file)
    samp.sha256 = sha256hash
    samp.sha1sum = sha1hash
    samp.md5sum = md5hash

    vt = VirusTotal.new
    detect = vt.vtquery(sha256hash)
    samp.detection = detect

    samp.save

  end


######################### PE Module ########################


  def scan_pe(sample)
    ## Analyzes PE Files

    ## Set Image File Header values ##
    #win32 = "014c"
    #itanium64 = "0200"
    #winamd64 = "8664"

    data =  pedumper(sample)

    return data
  end

######################### PDF Module ########################


  def scan_pdf(sample)
    ## Analyzes PDF Files
  end

######################### JPG Module ########################


  def scan_jpg(sample)
    ## Analyzes JPG files
    #img = EXIFR::JPEG.new
    #meta = img.inspect
    #puts meta
  end

######################### ELF Module ########################


  def scan_elf(sample)
    ## Provide hashes
    elf = Metasm::ELF.decode_file(sample)
    ## Output strings to file
    strings(sample)
  end


######################### Script Module ########################


  def scan_script(file)
    ## Analyzes Script files

    sample = File.open(file, 'r')
    contents = sample.readlines.first.chomp
  end


######################### Strings Module ########################


  def strings(sample)
    ## Writes file strings to a text file

    strings = `strings #{sample}`

  end
end