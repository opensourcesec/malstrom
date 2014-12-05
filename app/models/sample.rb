class Sample < ActiveRecord::Base
  has_attached_file :malz

  def samples
    render partial 'samples'
  end

  def signatures
    render partial 'signatures'
  end

  def upload
    render partial 'upload'
  end

  def upload_malz
    @sigs = Dir.pwd

  end
end
