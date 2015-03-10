require 'digest'
require 'analyzer'
require 'hex_string'
require 'archive/zip'
require 'archive/zip/codec/traditional_encryption'

class SamplesController < ApplicationController
  before_filter :authenticate_user!

  def list
    @all_malz = Sample.all
  end

  # malware downloads
  def download_malz
    file_name = params[:sample]
    base_name = File.basename(file_name, '.*')

    Archive::Zip.archive("tmp/#{base_name}.zip", # destination ZIP file
       "app/assets/malware/#{file_name}", # source file to add to ZIP
       #:encryption_codec => Archive::Zip::Codec::TraditionalEncryption, # encryption codec
       :password => 'infected') # ZIP password

    send_file "tmp/#{base_name}.zip", :type => 'application/octet-stream'

  end

  # malware upload function
  def upload_malz
    @sample = Sample.new( params[:sample] )
    @sample.malz = params[:malz]
    @sample.tag_list = params[:tag_list][:malz]
    if @sample.save
      if params[:box]
        if params[:passwd]
          unzipper(params[:sample], @sample.malz.path, params[:passwd][:box], params[:tag_list][:malz])
          @sample.malz.destroy
          @sample.delete
        else
          pass=''
          unzipper(params[:sample], @sample.malz.path, pass, params[:tag_list][:malz])
          @sample.malz.destroy
          @sample.delete
        end
        redirect_to samples_list_path, :notice => "Archive was extracted successfully!"
        return
      end
      redirect_to samples_list_path, :notice => "Sample was uploaded successfully!"
    end
    analyze = Analysis.new
    Thread.new { analyze.hashes(@sample.malz.path, @sample.malz_file_name) }
  end

  def unzipper(formdata, sample, zip_pass, tags)
    if zip_pass.length > 0
      if Archive::Zip.extract(sample, 'app/assets/malware', :password => zip_pass) do |zipfile|
        zipfile.each do |data|
          new_sample = Sample.create(formdata)
          new_sample.malz = File.open(data, 'rb')
          new_sample.tag_list = tags
          analyze = Analysis.new
          Thread.new { analyze.hashes(new_sample.malz.path, new_sample.malz_file_name) }
          end
        end
      end
    else
      if Archive::Zip.extract(sample) do |zipfile|
        zipfile.each do |data|
          new_sample = Sample.create(formdata)
          new_sample.malz = File.open(data, 'rb')
          new_sample.tag_list = tags
          analyze = Analysis.new
          Thread.new { analyze.hashes(new_sample.malz.path, new_sample.malz_file_name) }
          end
        end
      end
    end
  end

  # sample analysis function
  def analysis
    @sample = Sample.find_by_md5sum(params[:md5sum])
    contents = File.open(@sample.malz.path, 'rb')
    content = contents.read
    hex = content.to_hex_string
    magic = hex[0,5]
    scan = Analysis.new

    if magic == "4d 5a"
      @type = "PE"
      scan_results = scan.scan_pe(contents).html_safe
      @sample.deepdive = scan_results
    elsif magic == "ff d8"
      @type = "JPG"
      @page = scan.scan_jpg(content)
    elsif magic == "7f 45"
      @type = "ELF"
      @page = scan.scan_elf(content)
    elsif magic == "25 50"
      @type = "PDF"
      @page = "default"
    else
      @type = `file #{@sample.malz.path} | cut -d ':' -f 2`
      @page = "default"
    end
  end


  # parameterss for sample uploads
  def sample_params
    params.require(:sample).permit(:filename, :malz, :hash, :tags_list)
  end

  # malware removal function
  def delete_malz
    samps = Sample.find_by_id(params[:sample_id])
    samps.malz.destroy
    samps.delete
    redirect_to samples_list_path, :notice => "Sample deleted successfully!"
  end

  # add notes
  def add_note
    sample = Sample.find_by_id(params[:sample_id])
    note_contents = params[:note_content]
    sample.notes = note_contents
    if sample.save
      redirect_to samples_analysis_path(:md5sum => sample.md5sum), :notice => "Notes have been updated successfully!"
    else
      redirect_to samples_list_path, :alert => "Error: Could not save notes"
    end
  end

  # parameterss for notes
  def add_note_params
    params.require(:note_content, :sample_id)
  end

  # add yara signatures
  def add_rule
    new_rule_content = params[:rule_body]
    patt = 'rule.*\{'
    syntax_check = /#{patt}/.match(new_rule_content)
    if syntax_check.nil?
      redirect_to samples_list_path, :alert => "Syntax - 'rule <rulename> {' not found!"
      return
    end
    rule_name = params[:rule_name]
    new_rule_path = "app/assets/yara/#{rule_name}.yar"
    begin
      File.write(new_rule_path, new_rule_content)
      redirect_to samples_yara_path, :notice => "Signature has been uploaded successfully!"
    rescue
      redirect_to samples_yara_path, :alert => "Error: Could not create rule"
    end
  end

  # delete yara rule
  def remove_rule
    # delete rule here function here
    rule_name = params[:rule_name]
    rule_path = "app/assets/yara/#{rule_name}"
    begin
      File.delete(rule_path)
      redirect_to samples_yara_path, :notice => "Signature has been deleted successfully!"
    rescue
      redirect_to samples_yara_path, :alert => "Could not delete rule"
    end
  end
end
