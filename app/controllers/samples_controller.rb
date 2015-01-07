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
    redirect_to samples_list_path, :notice => "New signature has been uploaded successfully!"
  end
end
