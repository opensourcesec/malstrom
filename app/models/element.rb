class Element < ActiveRecord::Base
  has_many :elements, through: :tags
  has_many :tags
  has_one :whois

end
