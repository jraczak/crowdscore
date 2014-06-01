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
  
  def user_time_zone
    tz = Timezone::Zone.new :latlon => [user_location_data.lat, user_location_data.lng]
    return tz.active_support_time_zone
  end
  
  def time_at_user
    Time.zone.now.in_time_zone(user_time_zone).strftime("%l:%M%P")
  end

end