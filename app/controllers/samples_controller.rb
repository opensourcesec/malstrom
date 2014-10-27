class SamplesController < ApplicationController
  def samplelist
    respond_to do |format|
      format.js
    end
  end

  def yara
    respond_to do |format|
      format.js
    end
  end

  def upload
    respond_to do |format|
      format.js
    end
  end
end
