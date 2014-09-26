class Element < ActiveRecord::Base
  has_many :elements, through: :tags
  has_many :tags
  has_one :whois

  def self.search(search)
    results = find(:all, :conditions => ['value LIKE ?', search])
    if results.nil?
      flash.now[:alert] = "Error: 0 results found"
      render search_indicators_path
    else
      render search_index_path
    end
  end
end
