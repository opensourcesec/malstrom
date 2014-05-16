class Element < ActiveRecord::Base
  has_many :tags
  has_one :whois

  def self.where(value)
    # code here
  end
end
