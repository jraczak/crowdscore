class VenueSearch
  def self.search(term, page)
    Venue.search(include: [:venue_category, :venue_subcategory]) do
      fulltext term
      paginate page: page
    end
  end
end
