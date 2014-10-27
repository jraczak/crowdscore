module DistanceHelper

  def venue_distance_from_search_location(venue, location)
    search_location = Geokit::Geocoders::GoogleGeocoder.geocode(location)
    search_location.distance_to(venue).round(1)
  end

end