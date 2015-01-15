class Element < ActiveRecord::Base
  has_many :tags, as: :taggable
  has_one :whois

end
