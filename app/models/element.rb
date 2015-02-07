class Element < ActiveRecord::Base
  has_one :whois
  acts_as_taggable
end
