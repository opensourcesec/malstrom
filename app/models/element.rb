class Element < ActiveRecord::Base
  has_one :whois
  acts_as_taggable
  paginates_per 20
end
