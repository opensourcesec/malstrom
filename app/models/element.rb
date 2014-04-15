class Element < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_one :whois
end
