module UsersHelper

require "yaml"
require "json"

  def user_location_data
    if cookies[:stored_user_location]
      ActiveSupport::JSON.decode(cookies[:stored_user_location])
    else
      if cookies[:detected_user_location] 
        geoloc = Geokit::Geocoders::MultiGeocoder.reverse_geocode(cookies[:detected_user_location].split(","))
        cookies[:stored_user_location] = { value: ActiveSupport::JSON.encode(geoloc),
                                           expires: 15.minutes.from_now }
      elsif Geokit::Geocoders::IpGeocoder.geocode(request.env['REMOTE_ADDR']).success != false
        geoloc = Geokit::Geocoders::IpGeocoder.geocode(request.env['REMOTE_ADDR'])
        cookies[:stored_user_location] = { value: ActiveSupport::JSON.encode(geoloc),
                                           expires: 15.minutes.from_now }
      else
        false
      end
    end
  end
  
  def user_time_zone
    # Remove this web service call to test nearest_time_zone gem for faster local queries
    #tz = Timezone::Zone.new :latlon => [user_location_data.lat, user_location_data.lng]
    #tz = NearestTimeZone.to(user_location_data.lat, user_location_data.lng)
    #return tz.active_support_time_zone
    if user_location_data
      NearestTimeZone.to(user_location_data["lat"], user_location_data["lng"])
    else
      false
    end
  end
  
  def time_at_user
    if user_time_zone
      Time.zone.now.in_time_zone(user_time_zone).strftime("%l:%M%P")
    else
      false
    end
  end

end