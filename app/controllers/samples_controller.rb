class SamplesController < ApplicationController
  def samples
    render '_samples'
  end

  def signatures
    render '_signatures'
  end

  def upload
    render '_upload'
  end
end
