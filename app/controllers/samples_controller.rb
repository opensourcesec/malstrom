class SamplesController < ApplicationController

require 'digest'


  ## Required javascript to render partials ##
  def samplelist
    #samples partial
    respond_to do |format|
      format.js
    end
    @all_malz = Sample.all

  end

  def yara
    #yara sig partial
    respond_to do |format|
      format.js
    end

    @rules = Dir.entries('app/assets/yara/')
  end

  def upload
    #upload partial
    respond_to do |format|
      format.js
    end
  end
  ## End of JS for partials ##

  # malware upload functions
  def upload_malz
    @sample = Sample.new( params[:sample] )
    if params[:box]
      #Zip::File.open(@sample) do |zipfile|
      #  zipfile.each do |data|
      #    sha256hash = Digest::SHA256.file(params).hexdigest
      #    Sample.sha256 = sha256hash
      #  end
      #end
    else
      #sha256hash = Digest::SHA256.file(@sample.tempfile).hexdigest
      #Sample.SHA256 = sha256hash
    end
    @sample.filename = params[:filename]
    @sample.malz = params[:malz]
    if @sample.save
      redirect_to samples_list_path, :notice => "Sample has been uploaded successfully!"
    end
  end

  # params for sample uploads
  def sample_params
    params.require(:sample).permit(:filename, :malz, :hash)
  end

  # add yara signatures
  def add_rule
    new_rule_content = params[:rule_body]
    patt = 'rule.+\{'
    syntax_check = /#{patt}/.match(new_rule_content)
    if syntax_check.nil?
      redirect_to samples_list_path, :alert => "Error: Improper rule syntax: '#{syntax_check}'"
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
end
