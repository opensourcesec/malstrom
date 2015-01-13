require 'hex_string'
require 'digest'
require 'metasm'
require 'exifr'
require 'json'
require 'rest-client'

class Analysis

######################### Hashing Module ########################

  def hashes(sample, file)
    sha256hash = Digest::SHA256.file(file).hexdigest
    sha1hash = Digest::SHA1.file(file).hexdigest
    md5hash = Digest::MD5.file(file).hexdigest
    samp = Sample.find_by_malz_filename(sample)
    samp.SHA256 = sha256hash
  end


######################### PE Module ########################


  def scan_pe(sample)
    ## Analyzes PE Files

    ## Set Image File Header values ##
    win32 = "014c"
    itanium64 = "0200"
    winamd64 = "8664"

    ## Identify File Header relative to start of PE header ##
    offset = @hex.index "50 45 00 00"
    offset = offset + 12
    a = @hex[offset, 5]

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

    File.open("reports/#{@sample_name}.txt", "a") do |f1|  f1.write("\n[*] File Architecture: #{build}") end

    ## Outputs strings from sample to a file
    strings(sample)

    ## Searches Virustotal for sample
    VTotal::vtquery(sample, hash)
  end


######################### JPG Module ########################


  def scan_jpg(sample)
    ## Analyzes JPG files

    img = EXIFR::JPEG.new(sample)

    puts "\nTime the image was captured: ".yellow
    if img.date_time != nil
      puts "#{img.date_time}".yellow
    else
      puts '[!] No Timestamp available'.red
    end

    meta = img.exif_data
    puts "\nExif data: ".yellow
    if img.exif? == 'True'
      puts "#{meta}".yellow
    else
      puts '[!] No Exif data available'.red
    end
    vt_query(sample, hash)
  end

######################### ELF Module ########################


  def scan_elf(sample)
    ## Provide hashes

    elf = Metasm::ELF.decode_file(sample)

    ## Output strings to file
    strings(sample)

    ## Query VT for sample
    VTotal::vtquery(sample, hash)
  end


######################### Script Module ########################


  def scan_script(file)
    ## Analyzes Script files

    sample = File.open(file, 'r')
    contents = sample.readlines.first.chomp
    print "\n[*] Interpreter: ".yellow
    puts contents
    VTotal::vtquery(file, hash)
  end


######################### Strings Module ########################


  def strings(sample)
    ## Writes file strings to a text file

    strings = `strings #{sample}`

    begin
      File.open("reports/#{@sample_name}.txt", "a") do |f1| f1.write("\n[*] Output strings to strings/#{sample}_strings.txt\n") end
    rescue
      print "[-]".red
      puts " Could not output strings to file."
    end
  end
end