class Search
  paginates_per 20

  def self.search(query)
    where("value like ?", "%#{query}%")
  end
end