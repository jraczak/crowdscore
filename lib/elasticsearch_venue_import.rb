module ElasticsearchVenueImport

  def self.import
    Venue.includes(:venue_subcategory, :tips).find_in_batches do |venues|
      bulk_index(venues)
    end
  end
  
  def self.prepare_records(venues)
    venues.map do |venue|
      { index: { _id: venue.id, data: venue.as_indexed_json } }
    end
  end
  
  def self.bulk_index(venues)
    Venue.__elasticsearch__.client.bulk({
      index: ::Venue.__elasticsearch__.index_name,
      type: ::Venue.__elasticsearch__.document_type,
      body: prepare_records(venues)
    })
  end

end