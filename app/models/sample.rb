class Sample < ActiveRecord::Base
  def samples
    render partial 'samples'
  end

  def signatures
    render partial 'signatures'
  end

  def upload
    render partial 'upload'
  end
end
