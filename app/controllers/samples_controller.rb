class SamplesController < ApplicationController

@all_malz = Sample.all

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

    @rules = Dir.entries('app/assets/yara/')
  end

  def upload
    #upload partial
    respond_to do |format|
      format.js
    end
  end

  def upload_malz
    #upload malware with this function
    @sample = Sample.new(params[:sample])
    if @sample.save
      redirect_to samples_list_path, :notice => "Sample has been uploaded successfully!"
    end
  end

  def add_rule
    # add yara signatures
    new_rule_content = params[:rule_body]
    patt = 'rule.+\{'
    syntax_check = /#{patt}/.match(new_rule_content)
    if syntax_check.nil?
      redirect_to samples_list_path, :alert => "Error: Improper rule syntax: '#{syntax_check}'"
      return
    end
    rule_name = params[:rule_name]
    new_rule_path = "app/assets/yara/#{rule_name}"
    begin
      File.write(new_rule_path, new_rule_content)
      redirect_to samples_list_path, :notice => "New signature has been uploaded successfully!"
    rescue
      redirect_to samples_list_path, :alert => "Error: Could not create rule"
    end
  end
end
