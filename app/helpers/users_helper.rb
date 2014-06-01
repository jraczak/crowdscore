module UsersHelper

  def user_location_data
    if cookies[:user_location] 
      Geokit::Geocoders::MultiGeocoder.reverse_geocode(cookies[:user_location].split(","))
    elsif Geokit::Geocoders::IpGeocoder.geocode(request.env['REMOTE_ADDR']).success != false
      Geokit::Geocoders::IpGeocoder.geocode(request.env['REMOTE_ADDR'])
    else
      false
    end
  end

end