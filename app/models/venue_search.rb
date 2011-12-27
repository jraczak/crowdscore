class VenueSearch
  def self.search(params)
    if params[:zip].present?
      lat, long = Geocoder.coordinates(params[:zip])
    else
      lat = params[:latitude]
      long = params[:longitude]
    end

    fake_distance = 20 * 0.6214 # 1.5 miles

    Venue.search(include: [:venue_category, :venue_subcategory]) do
      fulltext params[:q].gsub(/[^\s\w]/, '')
      paginate page: params[:page]
      order_by_geodist :location, lat, long
      with(:location).in_radius(lat, long, fake_distance)
    end
  end
end
