class SamplesController < ApplicationController

require 'digest'
require 'zip'
require 'analyzer'
require 'hex_string'

  ## Required javascript to render partials ##
  def samplelist
    #samples partial
    respond_to do |format|
      format.js
    end
  end

  def yara
    #yara sig partial
    respond_to do |format|
      format.js
    end
  end

  def upload
    #upload partial
    respond_to do |format|
      format.js
    end
  end
  ## End of JS for partials ##

  # malware upload function
  def upload_malz
    @sample = Sample.new( params[:sample] )
    if params[:box]
      Zip::File.open(@sample) do |zipfile|
        zipfile.each do |data|
          @sample.malz = data
        end
      end
    end
    @sample.malz = params[:malz]

    if @sample.save
      redirect_to samples_list_path, :notice => "Sample has been uploaded successfully!"
      sleep(1)
      analyze = Analysis.new
      thr = Thread.new { analyze.hashes(@sample.malz.path, @sample.malz_file_name) }
      thr.join
    end
  end

  # sample analysis function
  def analysis
    scan = Analysis.new
    @sample = Sample.find_by_md5sum(params[:md5])
    contents = File.open(@sample.malz.path, 'rb')
    content = contents.read
    hex = content.to_hex_string
    magic = hex[0,5]
    if magic == "4d 5a"
      @type = "PE"
      @scan_results = scan.scan_pe(contents, hex)
    elsif magic == "ff d8"
      @type = "JPG"
      @page = scan.scan_jpg(content)
    elsif magic == "7f 45"
      @type = "ELF"
      @page = scan.scan_elf(content)
    elsif magic == "23 21"
      @type = "Script"
      @page = scan.scan_script(content)
    elsif magic == "25 50"
      @type = "PDF"
      @page = "default"
    else
      @type = "unknown!"
      @page = "default"
    end
  end


  # parameterss for sample uploads
  def sample_params
    params.require(:sample).permit(:filename, :malz, :hash)
  end

  # malware removal function
  def delete_malz
    samps = Sample.find_by_id(params[:sample_id])
    samps.malz.destroy
    samps.delete
    redirect_to :samples_list_path, :notice => "Sample deleted successfully!"
  end

  # add yara signatures
  def add_rule
    new_rule_content = params[:rule_body]
    patt = 'rule.*\{'
    syntax_check = /#{patt}/.match(new_rule_content)
    if syntax_check.nil?
      redirect_to samples_list_path, :alert => "Error: Syntax - 'rule <rulename> {' not found!"
      return
    end
    rule_name = params[:rule_name]
    new_rule_path = "app/assets/yara/#{rule_name}.yar"
    begin
      File.write(new_rule_path, new_rule_content)
      redirect_to samples_list_path, :notice => "New signature has been uploaded successfully!"
    rescue
      redirect_to samples_list_path, :alert => "Error: Could not create rule"
    end
  end

  # delete yara rule
  def remove_rule
    # delete rule here function here
  end
end
