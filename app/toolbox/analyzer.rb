require 'hex_string'
require 'digest'
require 'pedump'
require 'exifr'
require 'metasm'
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


  def scan_pe(sample, hex)
    ## Analyzes PE Files

    pe = PEdump.new
    #mz = pe.mz(sample)
    #dosstub = pe.dos_stub(sample)
    iat = pe.imports(sample)
    eat = pe.exports(sample)
    res = pe.resources(sample)


    ## Set Image File Header values ##
    #win32 = "014c"
    #itanium64 = "0200"
    #winamd64 = "8664"

    ## Identify File Header relative to start of PE header ##
    offset = hex.index "50 45 00 00"
    offset = offset + 12
    a = hex[offset, 5]

    test32 = a.index('4c 01')
    testia64 = a.index('00 02')
    test64 = a.index ('86 64')
    if test32.nil?
      if testia64.nil?
        if test64.nil?
          build = "Unknown"
        else
          build = "AMD-64 (64-bit x64)"
        end
      else
        build = "IA-64 (Itanium)"
      end
    else
      build = "i386 (32-bit x86)"
    end

    puts "Build: #{build}\nImports: #{iat}\nExports: #{eat}\nResources: #{res}"
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