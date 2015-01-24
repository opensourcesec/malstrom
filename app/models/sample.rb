class Sample < ActiveRecord::Base
  has_attached_file :malz,
                    :url  => "/assets/malware/:basename.:extension",
                    :path => ":rails_root/app/assets/malware/:basename.:extension"

  validates_attachment :malz,
                       :content_type => { :content_type => /^.*/ }
  validates_attachment_size :malz, :less_than => 10.megabytes
  # Allow tagging
  acts_as_taggable

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
