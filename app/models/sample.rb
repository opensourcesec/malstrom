class Sample < ActiveRecord::Base
  has_attached_file :malz
  validates_attachment :malz,
                       :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png", "application/pdf",
                                                            "application/zip", "application/gzip", "application/octet-stream", ] }

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
