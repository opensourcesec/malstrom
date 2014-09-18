class SamplesController < ApplicationController
  def samples
    render samples/list#samples_path
  end

  def signatures
    render samples/list#signatures_path
  end

  def upload
    render samples/list#upload_path
  end
end
