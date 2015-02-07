class Search

  def self.search(query)
    where("value like ?", "%#{query}%")
  end
end