class Element < ActiveRecord::Base
  has_many :tags
  has_one :whois

  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['value LIKE ? OR tag LIKE ?', search_condition, search_condition])
  end
end
