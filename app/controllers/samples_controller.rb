class SamplesController < ApplicationController
  def samples
    render partial '_samples'
  end

  def signatures
    render partial '_signatures'
  end

  def upload
    render partial '_upload'
  end
end
