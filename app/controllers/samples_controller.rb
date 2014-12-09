class SamplesController < ApplicationController
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
    @sample = Samples.new(sample_params)
    @sample.malz = params[:samples][:malz]
    if @sample.save
      redirect_to samples_list_path, :notice => "Malware has been uploaded successfully!"
  end

  def process_sig
    #processes saved yara signatures
    redirect_to samples_list_path, :notice => "New signature has been uploaded successfully!"
  end
end
