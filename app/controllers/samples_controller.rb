class SamplesController < ApplicationController
  def samples
    render "samples/samples"
  end

  def signatures
    render "samples/signatures"
  end

  def upload
    render "samples/upload"
  end
end
